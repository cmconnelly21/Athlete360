IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCnordbordfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCnordbord_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.WSOCnordbord L):= transform
																								SELF.date := STD.date.fromstringtodate(L.date,'%Y/%m/%d');
																								SELF.time := STD.date.fromstringtotime (L.time, '%H:%M');
																								SELF.Name := L.Name;
																								SELF.Test := L.Test;
																								SELF.REPS_L := (UNSIGNED1)L.REPS_L;
																								SELF.REPS_R := (UNSIGNED1)L.REPS_R;
																								SELF.MAX_FORCE_L := (DECIMAL5_2)L.MAX_FORCE_L;
																								SELF.MAX_FORCE_R := (DECIMAL5_2)L.MAX_FORCE_L;
																								SELF.MAX_IMBALANCE := (DECIMAL5_2)L.MAX_IMBALANCE;
																								SELF.MAX_TORQUE_L := (DECIMAL5_2)L.MAX_TORQUE_L;
																								SELF.MAX_TORQUE_R := (DECIMAL5_2)L.MAX_TORQUE_R;
																								SELF.AVG_FORCE_L := (DECIMAL5_2)L.AVG_FORCE_L;
																								SELF.AVG_FORCE_R := (DECIMAL5_2)L.AVG_FORCE_R;
																								SELF.AVG_IMBALANCE := (DECIMAL5_2)L.AVG_IMBALANCE;
																								SELF.AVG_TORQUE_L := (DECIMAL5_2)L.AVG_TORQUE_L;
																								SELF.AVG_TORQUE_R := (DECIMAL5_2)L.AVG_TORQUE_R;
																								SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCnordbord_stgfile,
            NAME, DATE, TIME, -wuid),
        NAME, DATE, TIME
    );

mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(dedup(sort(Athlete360.files_stg.WSOCnordbord_stgfile, name), name),

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := RIGHT.athleteid; SELF := LEFT;),

left only

);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCnordbord := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCnordbord_name, completestgData);