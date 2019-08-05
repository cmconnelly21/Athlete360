IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCrawgpsfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCrawgps_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.WSOCrawgps L):= transform
																								SELF.time := STD.date.fromstringtotime (L.time[1..8], '%H:%M:%S');
																								SELF.Name := L.Name;
																								Self.Date := STD.date.fromstringtodate (L.filename[47..55],'%d-%m-%Y');
																								SELF.PlayerID := (UNSIGNED3)L.PlayerID;
																								SELF.HeartRate := (UNSIGNED3)L.HeartRate;
																								SELF.ElapsedTime := (DECIMAL10_5)L.ElapsedTime;
																								SELF.Latitude := (DECIMAL10_5)L.Latitude;
																								SELF.Longitude := (DECIMAL10_5)L.Longitude;
																								SELF.Speed := (DECIMAL10_5)L.Speed;
																								SELF.Accelimpulse := (DECIMAL10_5)L.Accelimpulse;
																								SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCrawgps_stgfile,
            NAME, ElapsedTime, -wuid),
        NAME, ElapsedTime
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
EXPORT build_WSOCrawgps := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCrawgps_name, completestgData);