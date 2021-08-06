IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WBBdrillsfile;

stglayout := Athlete360.layouts.WBBdrills_stg;


stgLayout extractdata (Athlete360.Layouts.WBBdrills L):= transform
                  SELF.periodid := (unsigned3)L.periodid;
									SELF.period := L.period;
									SELF.wuid := (STRING19)workunit;
END;
									


cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

FinalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WBBdrills_stgfile,
            periodid, -wuid),
        periodid
    );

// OUTPUT(sprayfile);
// OUTPUT(cleanedSprayFile);
// OUTPUT(FinalStageData);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WBBdrills := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WBBdrills_name, finalStageData);