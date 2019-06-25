IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCjumpfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCjump_stg;

// do all preprocessing actions and get the cleaned data from spray
cleanedSprayFile := sprayFile;
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCjump_stgfile,
            NAME, DATE, -wuid),
        NAME, DATE
    );

mapfile := Athlete360.files_stg.atheleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
join(finalStageData, mapfile,
    left.name = right.name
    transform(,
        self.athleteid := right.athleteid
        self := left
    )
);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCjump := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCjump_name, finalStageData);