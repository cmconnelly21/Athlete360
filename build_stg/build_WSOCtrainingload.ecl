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


// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCtrainingload := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCtrainingload_name, completestgdata);