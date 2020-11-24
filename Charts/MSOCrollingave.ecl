IMPORT Athlete360;
IMPORT STD;
#option('outputlimit',2000);

//pull data from readiness stage file and join with data from training loads stage file
rawDs := SORT(Athlete360.files_stg.MSOCreadiness_stgfile, Date, Name) : INDEPENDENT;

completedata := join(dedup(sort(rawDs, name, date), name, date),

Athlete360.files_stg.MSOCtrainingload_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND
left.date = right.date,

transform({RECORDOF(LEFT), Right.trainingload, integer cnt},
									self.cnt := COUNTER;
									self.daynum := left.daynum;
									SELF.date := IF(left.date <> right.date, left.date, right.date);
									SELF.time := IF(left.date <> right.date, left.time, right.time);
                  self.Name := IF(left.date <> right.date, left.Name, right.Name);
									self.Fatigue := IF(left.date <> right.date, left.Fatigue, left.Fatigue);
									self.Soreness := IF(left.date <> right.date, left.Soreness, left.Soreness);
									self.SleepQuality := IF(left.date <> right.date, left.SleepQuality, left.SleepQuality);
									self.Stress := IF(left.date <> right.date, left.Stress, left.Stress);
									SELF.mood := IF(left.date <> right.date, left.mood, left.mood);
									SELF.Sleephours := IF(left.date <> right.date, left.Sleephours, left.Sleephours);
									SELF.Athleteid := IF(left.date <> right.date, left.Athleteid, right.Athleteid);
									self.Score := IF(left.date <> right.date, left.Score, left.Score);
									SELF.trainingload := IF(left.date <> right.date, 0, right.trainingload);
									SELF.wuid := workunit; 
									),

 left outer

);

//add count to dataset
// inputDs := PROJECT(completedata, TRANSFORM({RECORDOF(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));


//define how the count will work
// completedataUniqueName := DEDUP(SORT(completedata1, name), name);


//create and define the averages using the count to find averages based on previous 2 and 4 days
temp3 := RECORD
  unsigned4 date;
  unsigned3 time;
	unsigned3 daynum;
  string name;
  decimal5_2 score;
  unsigned4 athleteid;
  unsigned1 trainingload;
  decimal5_2 trainingload_roll2;
  decimal5_2 score_roll2;
  decimal5_2 trainingload_roll4;
  decimal5_2 score_roll4;
	integer cnt;
 END;


dataWithAvgs := project
    (
        completedata,
        Transform(
	        { RECORDOF(temp3)},
  	        SELF.TrainingLoad_roll2 := AVE(completedata(name = LEFT.name AND right.cnt > LEFT.cnt-2 AND right.cnt <= left.cnt), TrainingLoad);
  	        SELF.score_roll2 := AVE(completedata(name = LEFT.name AND right.cnt > LEFT.cnt-2 AND right.cnt <= left.cnt),score);
						SELF.TrainingLoad_roll4 := AVE(completedata(name = LEFT.name AND right.cnt > LEFT.cnt-4 AND right.cnt <= left.cnt), TrainingLoad);
  	        SELF.score_roll4 := AVE(completedata(name = LEFT.name AND right.cnt > LEFT.cnt-4 AND right.cnt <= left.cnt),score);
            SELF := LEFT
        )     
    );

//output data and create output file

gameday := JOIN(dataWithAvgs,ATHLETE360.files_stg.MSOCdate_stgfile,
			left.date = RIGHT.date,
			TRANSFORM({RECORDOF(LEFT); ATHLETE360.files_stg.MSOCdate_stgfile.gamedaycount},
			SELF.gamedaycount := RIGHT.gamedaycount;
			SELF := LEFT));
	// OUTPUT(rawds[1..100000]);
	OUTPUT(completedata,all);
	output(sorted_completedata);
	OUTPUT(replaceMediansOnEmptycompletedatas,all);
	// OUTPUT(dataWithAvgs[1..100000]);
	// OUTPUT(gameday[1..100000]);  


// OUTPUT(gameday,,'~Athlete360::OUT::despray::MSOCrollingave',CSV,OVERWRITE);