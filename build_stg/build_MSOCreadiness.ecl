IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.MSOCreadinessfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.MSOCreadiness_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.MSOCreadiness L):= transform
									SELF.Date := STD.date.FromStringToDate(L.Date,'%Y-%m-%d');
									SELF.Time := IF(std.str.splitwords(L.Time, ' ')[2]='PM',
									1200 + STD.date.FromStringToTime(L.Time,'%H:%M'),
									STD.date.FromStringToTime(L.Time,'%H:%M'));
                  self.Name := L.Firstname + ' ' + L.Lastname;
									self.Score := (DECIMAL5_2)L.Score;
									self.Fatigue := (Unsigned1)L.Fatigue;
									self.Mood := (Unsigned1)L.Mood;
									self.Soreness := (Unsigned1)L.Soreness;
									self.Stress := (Unsigned1)L.Stress;
									self.SleepQuality := (Unsigned1)L.SleepQuality;
									self.SleepHours := (unsigned1)L.SleepHours;
									SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.MSOCreadiness_stgfile,
            NAME, DATE, TIME, -wuid),
        NAME, DATE, TIME
    );

mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(finalStageData(time <> 0),

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := RIGHT.athleteid; SELF := LEFT;),

left outer

);

completedataUniqueName := DEDUP(SORT(completestgdata, name), name);


RECORDOF(completestgdata) denormalizeToFindMedian(RECORDOF(completestgdata) L, DATASET(RECORDOF(completestgdata)) R1) := TRANSFORM
    R := R1[1..30];
		
    SELF.Score := IF(COUNT(R) % 2 = 1, 
                            SORT(R, Score)[(COUNT(R) / 2 ) + 1].Score, 
                            (SORT(R, Score)[(COUNT(R) / 2 ) + 1].Score  + SORT(R, Score)[(COUNT(R) / 2)].Score ) / 2
                        );
    // SELF.sessionoverall := IF(COUNT(R) % 2 = 1, 
                            // SORT(R, sessionoverall)[(COUNT(R) / 2 ) + 1].sessionoverall, 
                            // (SORT(R, sessionoverall)[(COUNT(R) / 2 ) + 1].sessionoverall  + SORT(R, sessionoverall)[(COUNT(R) / 2)].sessionoverall ) / 2
                        // );
    
    SELF := L;

 END;

//denormalize to seperate by athlete to find median values
completedataWithMedians := DENORMALIZE
    (
        completedataUniqueName, 
        completestgdata,
        LEFT.name = RIGHT.name,
        GROUP,
        denormalizeToFindMedian(LEFT, ROWS(RIGHT))        
    );
		// JOIN(DATE, 30
		// completedataWithMedians, 3
		// TRUE,
		// 90 RECS
		
addmissingdates := JOIN(ATHLETE360.files_stg.MSOCdate_stgfile, completedataWithMedians, true, ALL);

replaceMediansOnEmptycompletedatas := JOIN
    (
        completestgdata(name <> ' '),
        addmissingdates(date <> 0),
        LEFT.name = RIGHT.name AND
				LEFT.date = RIGHT.date,
        TRANSFORM({RECORDOF(LEFT), boolean isdummy := FALSE},
									SELF.date := IF(LEFT.date <> 0, LEFT.date, RIGHT.date);
									SELF.time := IF(LEFT.time <> 0, LEFT.time, RIGHT.time);
                  self.Name := IF(LEFT.Name <> ' ', LEFT.Name, RIGHT.Name);
									self.Fatigue := IF(LEFT.Fatigue <> 0, LEFT.Fatigue, RIGHT.Fatigue);
									self.Soreness := IF(LEFT.Soreness <> 0, LEFT.Soreness, RIGHT.Soreness);
									self.SleepQuality := IF(LEFT.SleepQuality <> 0, LEFT.SleepQuality, RIGHT.SleepQuality);
									self.Stress := IF(LEFT.Stress <> 0, LEFT.Stress, RIGHT.Stress);
									self.mood := IF(LEFT.mood <> 0, LEFT.mood, RIGHT.mood);
									SELF.SleepHours := IF(LEFT.SleepHours <> 0, LEFT.SleepHours, RIGHT.SleepHours);
									self.Score := IF(LEFT.Score <> 0, LEFT.Score, RIGHT.Score);
									self.isdummy := IF(left.name = ' ' AND left.date = 0, true, false);
									SELF.wuid := workunit;
            // SELF.sessionoverall := IF(LEFT.sessionoverall <> 0, LEFT.sessionoverall, RIGHT.sessionoverall);
        ),
        Full Outer
    );

// OUTPUT(cleanedsprayfile[1..5000]);		
// OUTPUT(completestgdata[1..5000]);
// OUTPUT(completedataWithMedians[1..5000]);
// OUTPUT(sort(addmissingdates(date<>0),name,date)[1..5000]);
// OUTPUT(replaceMediansOnEmptycompletedatas[1..5000]);

// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_MSOCreadiness := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCreadiness_name, replaceMediansOnEmptycompletedatas);