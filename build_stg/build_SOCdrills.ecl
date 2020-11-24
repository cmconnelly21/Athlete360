IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.SOCdrillsfile;

stglayout := Athlete360.layouts.SOCdrills_stg;


stgLayout extractdata (Athlete360.Layouts.SOCdrills L):= transform
                  SELF.drillname := L.drillname;
									SELF.drillnum := (unsigned3)L.drillnum;
									SELF.wuid := (STRING19)workunit;
END;
									


cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

FinalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.SOCdrills_stgfile,
            drillnum, -wuid),
        drillnum
    );

// OUTPUT(sprayfile);
// OUTPUT(cleanedSprayFile);
// OUTPUT(FinalStageData);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_SOCdrills := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.SOCdrills_name, finalStageData);