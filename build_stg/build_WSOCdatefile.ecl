IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCdatefile;

stglayout := Athlete360.layouts.WSOCdatefile_stg;


stgLayout extractdata (Athlete360.Layouts.WSOCdatefile L):= transform
                  SELF.date := STD.date.FromStringToDate(L.date,'%m/%d/%Y');
									SELF.gamedaycount := (STRING20)L.gamedaycount;
									SELF.wuid := (STRING19)workunit;
END;
									


cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCdate_stgfile,
            DATE, -wuid),
        DATE
    );

// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCdatefile := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCdate_name, finalStageData);