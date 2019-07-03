IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCreadinessfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCreadiness_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.WSOCreadiness L):= transform
                  SELF.date := STD.date.FromStringToDate(L.Timestamp,'%m/%d/%Y');
									SELF.time := STD.date.FromStringToTime(L.Timestamp,'%H:%M:%S');
                  self.Name := L.Name;
									self.Fatigue := (Unsigned1)L.Fatigue;
									self.MuscleSoreness := (Unsigned1)L.MuscleSoreness;
									self.SleepQuality := (Unsigned1)L.SleepQuality;
									self.Stress := (Unsigned1)L.Stress;
									self.Hydration := (Unsigned1)L.Hydration;
									SELF.Pain := L.Pain;
									SELF.Explanation := L.Explanation;
									self.WellnessSum := (Unsigned1)L.WellnessSum;
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
completestgdata := join(finalStageData,

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := RIGHT.athleteid; SELF := LEFT;),

left outer

);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCreadiness := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCreadiness_name, completestgData);