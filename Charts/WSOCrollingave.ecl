IMPORT Athlete360;
IMPORT STD;
#option('outputlimit',2000);

//pull data from readiness stage file and join with data from training loads stage file
rawDs := SORT(Athlete360.files_stg.WSOCreadiness_stgfile, Date, Name) : INDEPENDENT;

completedata := join(dedup(sort(rawDs, name, date), name, date),

Athlete360.files_stg.WSOCtrainingload_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND
left.date = right.date,

transform({RECORDOF(LEFT), Right.sessionoverall},
									SELF.date := IF(left.date <> right.date, left.date, right.date);
									SELF.time := IF(left.date <> right.date, left.time, right.time);
                  self.Name := IF(left.date <> right.date, left.Name, right.Name);
									self.Fatigue := IF(left.date <> right.date, left.Fatigue, left.Fatigue);
									self.MuscleSoreness := IF(left.date <> right.date, left.MuscleSoreness, left.MuscleSoreness);
									self.SleepQuality := IF(left.date <> right.date, left.SleepQuality, left.SleepQuality);
									self.Stress := IF(left.date <> right.date, left.Stress, left.Stress);
									self.Hydration := IF(left.date <> right.date, left.Hydration, left.Hydration);
									SELF.Pain := IF(left.date <> right.date, left.Pain, left.Pain);
									SELF.Explanation := IF(left.date <> right.date, left.Explanation, left.Explanation);
									SELF.Athleteid := IF(left.date <> right.date, left.Athleteid, right.Athleteid);
									self.WellnessSum := IF(left.date <> right.date, left.WellnessSum, left.WellnessSum);
									SELF.sessionoverall := IF(left.date <> right.date, 0, right.sessionoverall);
									SELF.wuid := workunit; 
									),

 left outer

);


//add count to dataset
// inputDs := PROJECT(completedata, TRANSFORM({RECORDOF(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));


//define how the count will work
completedataUniqueName := DEDUP(SORT(completedata, name), name);


//define what median values to find
replaceMediansOnEmptycompletedatas := JOIN
    (
        completedata,
        completedataUniqueName,
        LEFT.name = RIGHT.name,
        TRANSFORM(RECORDOF(LEFT),
            SELF.wellnesssum := IF(LEFT.wellnesssum <> 0, LEFT.wellnesssum, RIGHT.wellnesssum);
            SELF.sessionoverall := IF(LEFT.sessionoverall <> 0, LEFT.sessionoverall, RIGHT.sessionoverall);
            SELF := LEFT
        ),
        LEFT OUTER
    );

//add median values to dataset
replaceMediansOnEmptycompletedatasProj := PROJECT
    (
        replaceMediansOnEmptycompletedatas, 
        TRANSFORM(
            {RECORDOF(LEFT); integer cnt}, 
            SELF.cnt := COUNTER; 
            self := left
        )
    );

//add the count to the data with the median values
replaceMediansOnEmptycompletedatasWithCnt := iterate
    (
        sort
            (
                replaceMediansOnEmptycompletedatasProj,
                Name,Date
            ), 
        transform(
            {replaceMediansOnEmptycompletedatas, integer cnt}, 
            self.cnt := IF(counter = 1 OR left.name <> right.name, 1, left.cnt+ 1 ); 
            self := right
        )
    );
		
//sort by name
replaceMediansOnEmptycompletedatasWithCntSorted := SORT
    (
        replaceMediansOnEmptycompletedatasWithCnt ,
        Name,cnt
    );

//create and define the averages using the count to find averages based on previous 2 and 4 days
temp3 := RECORD
  unsigned4 date;
  unsigned3 time;
  string name;
  decimal5_2 wellnesssum;
  string20 athleteid;
  unsigned1 sessionoverall;
  decimal5_2 sessionoverall_roll2;
  decimal5_2 wellnesssum_roll2;
  decimal5_2 sessionoverall_roll4;
  decimal5_2 wellnesssum_roll4;
 END;


dataWithAvgs := project
    (
        replaceMediansOnEmptycompletedatasWithCntSorted,
        Transform(
	        { RECORDOF(temp3)},           
  	        SELF.sessionoverall_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt), sessionoverall);
  	        SELF.wellnesssum_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt),wellnesssum);
						SELF.sessionoverall_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt), sessionoverall);
  	        SELF.wellnesssum_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt),wellnesssum);
            SELF := LEFT
        )     
    );

//output data and create output file    

 gameday := JOIN(dataWithAvgs,ATHLETE360.files_stg.WSOCdate_stgfile,
			left.date = RIGHT.date,
			TRANSFORM({RECORDOF(LEFT); ATHLETE360.files_stg.WSOCdate_stgfile.gamedaycount},
			SELF.gamedaycount := RIGHT.gamedaycount;
			SELF := LEFT));
	// OUTPUT(rawds[1..100000]);
	// OUTPUT(completedata[1..100000]);
	// OUTPUT(dataWithAvgs[1..100000]);
	// OUTPUT(gameday);

OUTPUT(gameday,,'~Athlete360::OUT::despray::WSOCrollingave',CSV,OVERWRITE);