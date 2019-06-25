IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.Athleteinfofile ;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.Athleteinfo;

// do all preprocessing actions and get the cleaned data from spray
cleanedSprayFile := sprayFile;
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.Athleteinfo_stgfile,
            athleteID, -wuid),
        athleteID
    );

// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_Athleteinfofile := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.Athleteinfo_name , finalStageData);