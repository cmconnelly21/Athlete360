IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCtrainingloadfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCtrainingload_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.WSOCtrainingload L):= transform
                  SELF.date := STD.date.FromStringToDate(L.Timestamp,'%m/%d/%Y');
									SELF.time := STD.date.FromStringToTime(STD.Str.SplitWords(L.Timestamp, ' ')[2],'%H:%M:%S');
                  self.Name := L.Name;
									self.SessionType := L.SessionType;
									self.SessionDuration := (Unsigned1)L.SessionDuration;
                  self.Breathlessness := (Unsigned1)L.Breathlessness;
                  self.LowerBodyLoad := (Unsigned1)L.LowerBodyLoad;
                  self.UpperBodyLoad := (Unsigned1)L.UpperBodyLoad;
                  self.SessionOverall := (Unsigned1)L.SessionOverall;
									SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCtrainingload_stgfile,
            NAME, DATE, TIME, -wuid),
        NAME, DATE, TIME
    );

mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(finalStageData,

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := RIGHT.athleteid; SELF := LEFT;),

left outer

);

completedataUniqueName := DEDUP(SORT(completestgdata, name), name);


RECORDOF(completestgdata) denormalizeToFindMedian(RECORDOF(completestgdata) L, DATASET(RECORDOF(completestgdata)) R1) := TRANSFORM
    R := R1[1..30];
		
    // SELF.wellnesssum := IF(COUNT(R) % 2 = 1, 
                            // SORT(R, wellnesssum)[(COUNT(R) / 2 ) + 1].wellnesssum, 
                            // (SORT(R, wellnesssum)[(COUNT(R) / 2 ) + 1].wellnesssum  + SORT(R, wellnesssum)[(COUNT(R) / 2)].wellnesssum ) / 2
                        // );
    SELF.sessionoverall := IF(COUNT(R) % 2 = 1, 
                            SORT(R, sessionoverall)[(COUNT(R) / 2 ) + 1].sessionoverall, 
                            (SORT(R, sessionoverall)[(COUNT(R) / 2 ) + 1].sessionoverall  + SORT(R, sessionoverall)[(COUNT(R) / 2)].sessionoverall ) / 2
                        );
    
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
replaceMediansOnEmptycompletedatas := JOIN
    (
        completestgdata,
        completedataWithMedians,
        LEFT.name = RIGHT.name,
        TRANSFORM(RECORDOF(LEFT),
            // SELF.wellnesssum := IF(LEFT.wellnesssum <> 0, LEFT.wellnesssum, RIGHT.wellnesssum);
            SELF.sessionoverall := IF(LEFT.sessionoverall <> 0, LEFT.sessionoverall, RIGHT.sessionoverall);
            SELF := LEFT
        ),
        Full OUTER
    );
		
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCtrainingload := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCtrainingload_name, replaceMediansOnEmptycompletedatas);