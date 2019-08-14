IMPORT Athlete360, STD;
#option('outputlimit',2000);

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.MSOCdatefile;


cleanedSprayFile := sprayFile;
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.MSOCdate_stgfile,
            DATE, -wuid),
        DATE
    );

// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_MSOCdatefile := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCdate_name, finalStageData);