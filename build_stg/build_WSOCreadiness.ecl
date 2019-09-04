IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCreadinessfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCreadiness_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.WSOCreadiness L):= transform
                  SELF.date := STD.date.FromStringToDate(STD.Str.SplitWords(L.Timestamp, ' ')[1],'%m/%d/%Y');
									SELF.time := STD.date.FromStringToTime(STD.Str.SplitWords(L.Timestamp, ' ')[2],'%H:%M:%S');
                  self.Name := L.Name;
									self.Fatigue := (Unsigned1)L.Fatigue;
									self.MuscleSoreness := (Unsigned1)L.MuscleSoreness;
									self.SleepQuality := (Unsigned1)L.SleepQuality;
									self.Stress := (Unsigned1)L.Stress;
									self.Hydration := (Unsigned1)L.Hydration;
									SELF.Pain := L.Pain;
									SELF.Explanation := L.Explanation;
									self.WellnessSum := (Unsigned1)L.Fatigue + L.MuscleSoreness + L.SleepQuality + L.Stress + L.Hydration;
									SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCreadiness_stgfile,
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
		
    SELF.wellnesssum := IF(COUNT(R) % 2 = 1, 
                            SORT(R, wellnesssum)[(COUNT(R) / 2 ) + 1].wellnesssum, 
                            (SORT(R, wellnesssum)[(COUNT(R) / 2 ) + 1].wellnesssum  + SORT(R, wellnesssum)[(COUNT(R) / 2)].wellnesssum ) / 2
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
		
addmissingdates := JOIN(ATHLETE360.files_stg.WSOCdate_stgfile, completedataWithMedians, true, ALL);

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
									self.MuscleSoreness := IF(LEFT.MuscleSoreness <> 0, LEFT.MuscleSoreness, RIGHT.MuscleSoreness);
									self.SleepQuality := IF(LEFT.SleepQuality <> 0, LEFT.SleepQuality, RIGHT.SleepQuality);
									self.Stress := IF(LEFT.Stress <> 0, LEFT.Stress, RIGHT.Stress);
									self.Hydration := IF(LEFT.Hydration <> 0, LEFT.Hydration, RIGHT.Hydration);
									SELF.Pain := LEFT.Pain;
									SELF.Explanation := LEFT.Explanation;
									self.WellnessSum := IF(LEFT.wellnesssum <> 0, LEFT.wellnesssum, RIGHT.wellnesssum);
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
EXPORT build_WSOCreadiness := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCreadiness_name, replaceMediansOnEmptycompletedatas);