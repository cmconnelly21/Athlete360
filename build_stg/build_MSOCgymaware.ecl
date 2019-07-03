IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.MSOCgymawarefile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.MSOCgymaware_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.MSOCgymaware L):= transform
																								SELF.date := STD.date.fromstringtodate(L.date[1..10],'%d/%m/%Y');
																								self.Name := L.Firstname + ' ' + L.Lastname;
																								SELF.Exercise := L.Exercise;
																								SELF.SetNumber := (UNSIGNED1)L.SetNumber;
																								SELF.MeanPower_bestrep := (UNSIGNED3)L.MeanPower_bestrep;
																								SELF.MeanPower_bestset := (UNSIGNED3)L.MeanPower_bestset;
																								SELF.PeakPower_bestrep := (UNSIGNED3)L.PeakPower_bestrep;
																								SELF.PeakPower_bestset := (UNSIGNED3)L.PeakPower_bestset;
																								SELF.LiftWeight := (DECIMAL5_2)L.LiftWeight;
																								SELF.Heightavg := (DECIMAL5_2)L.Heightavg;
																								SELF.Height_bestrep := (DECIMAL5_2)L.Height_bestrep;
																								SELF.MeanForce_bestrep := (DECIMAL5_2)L.MeanForce_bestrep;
																								SELF.MeanForce_bestset := (DECIMAL5_2)L.MeanForce_bestset;
																								SELF.MeanVelocity_bestrep := (DECIMAL5_2)L.MeanVelocity_bestrep;
																								SELF.MeanVelocity_bestset := (DECIMAL5_2)L.MeanVelocity_bestset;
																								SELF.Meanwkg_bestset := (DECIMAL5_2)L.Meanwkg_bestset;
																								SELF.PeakForce_bestrep := (DECIMAL5_2)L.PeakForce_bestrep;
																								SELF.PeakForce_bestset := (DECIMAL5_2)L.PeakForce_bestset;
																								SELF.PeakVelocity_bestrep := (DECIMAL5_2)L.PeakVelocity_bestrep;
																								SELF.PeakVelocity_bestset := (DECIMAL5_2)L.PeakVelocity_bestset;
																								SELF.Peakwkg_bestset := (DECIMAL5_2)L.Peakwkg_bestset;
																								SELF.TotalTonnage := (DECIMAL5_2)L.TotalTonnage;
																								SELF.TotalWork := (DECIMAL5_2)L.TotalWork;
																								SELF.Weight_bestset := (DECIMAL5_2)L.Weight_bestset;
																								SELF.Workavg := (DECIMAL5_2)L.Workavg;
																								SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.MSOCgymaware_stgfile,
            NAME, DATE, -wuid),
        NAME, DATE
    );

mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(dedup(sort(finalStageData, name), name),

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := RIGHT.athleteid; SELF := LEFT;),

left only

);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_MSOCgymaware := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCgymaware_name, completestgData);