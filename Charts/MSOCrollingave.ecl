IMPORT Athlete360;
IMPORT STD;
#option('outputlimit',2000);

//pull data from readiness stage file and join with data from training loads stage file
rawDs := SORT(Athlete360.files_stg.MSOCreadiness_stgfile, Date, Name) : INDEPENDENT;

completedata := join(dedup(sort(rawDs, name), name),

Athlete360.files_stg.MSOCtrainingload_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT), Right.trainingload}, 
														SELF.name := RIGHT.name; 
														SELF.Date := RIGHT.Date;
														SELF.trainingload := Right.trainingload;
														SELF := LEFT;), 

left outer

);

//add count to dataset
inputDs := PROJECT(completedata, TRANSFORM({RECORDOF(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));


//define how the count will work
completedataUniqueName := DEDUP(SORT(completedata, name), name);


//define what median values to find
replaceMediansOnEmptycompletedatas := JOIN
    (
        completedata,
        completedataUniqueName,
        LEFT.name = RIGHT.name,
        TRANSFORM(RECORDOF(LEFT),
            SELF.score := IF(LEFT.score <> 0, LEFT.score, RIGHT.score);
            SELF.TrainingLoad := IF(LEFT.TrainingLoad <> 0, LEFT.TrainingLoad, RIGHT.TrainingLoad);
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
            {completedata, integer cnt}, 
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
  decimal5_2 score;
  string20 athleteid;
  unsigned1 trainingload;
  decimal5_2 trainingload_roll2;
  decimal5_2 score_roll2;
  decimal5_2 trainingload_roll4;
  decimal5_2 score_roll4;
 END;


dataWithAvgs := project
    (
        replaceMediansOnEmptycompletedatasWithCntSorted,
        Transform(
	        { RECORDOF(temp3)},           
  	        SELF.TrainingLoad_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt), TrainingLoad);
  	        SELF.score_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt),score);
						SELF.TrainingLoad_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt), TrainingLoad);
  	        SELF.score_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt),score);
            SELF := LEFT
        )     
    );

//output data and create output file

// Name := JOIN(dataWithAvgs,ATHLETE360.files_stg.MSOCdate_stgfile,
			// left.date = RIGHT.date,
			// TRANSFORM({RECORDOF(LEFT); ATHLETE360.files_stg.MSOCdate_stgfile.gamedaycount},
			// SELF.gamedaycount := RIGHT.gamedaycount;
			// SELF := LEFT));
	// OUTPUT(Name[1..100]);	
	// OUTPUT(dataWithAvgs[1..100]);
	// OUTPUT(ATHLETE360.files_stg.MSOCdate_stgfile, all);    


OUTPUT(dataWithAvgs,,'~Athlete360::OUT::despray::MSOCrollingave',CSV,OVERWRITE);