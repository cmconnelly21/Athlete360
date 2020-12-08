IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.MSOCgpsfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.MSOCgps_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.MSOCgps L):= transform
																								SELF.date := STD.date.fromstringtodate(L.date,'%d/%m/%Y');
																								SELF.Name := L.Name;
																								SELF.Drillname := Athlete360.util.toUpperTrim(L.Drillname);
																								SELF.Week := (UNSIGNED1)L.Week;
																								SELF.Position := L.Position;
																								SELF.Impacts := (DECIMAL5_2)L.Impacts;
																								SELF.Impactsz1 := (DECIMAL5_2)L.Impactsz1;
																								SELF.Impactsz2 := (DECIMAL5_2)L.Impactsz2;
																								SELF.Impactsz3 := (DECIMAL5_2)L.Impactsz3;
																								SELF.Impactsz4 := (DECIMAL5_2)L.Impactsz4;
																								SELF.Impactsz5 := (DECIMAL5_2)L.Impactsz5;
																								SELF.Impactsz6 := (DECIMAL5_2)L.Impactsz6;
																								SELF.Accelerations := (DECIMAL5_2)L.Accelerations;
																								SELF.Accelerationsz1 := (DECIMAL5_2)L.Accelerationsz1;
																								SELF.Accelerationsz2 := (DECIMAL5_2)L.Accelerationsz2;
																								SELF.Accelerationsz3 := (DECIMAL5_2)L.Accelerationsz3;
																								SELF.Accelerationsz4 := (DECIMAL5_2)L.Accelerationsz4;
																								SELF.Accelerationsz5 := (DECIMAL5_2)L.Accelerationsz5;
																								SELF.Accelerationsz6 := (DECIMAL5_2)L.Accelerationsz6;
																								SELF.Decelerations := (DECIMAL5_2)L.Decelerations;
																								SELF.Decelerationsz1 := (DECIMAL5_2)L.Decelerationsz1;
																								SELF.Decelerationsz2 := (DECIMAL5_2)L.Decelerationsz2;
																								SELF.Decelerationsz3 := (DECIMAL5_2)L.Decelerationsz3;
																								SELF.Decelerationsz4 := (DECIMAL5_2)L.Decelerationsz4;
																								SELF.Decelerationsz5 := (DECIMAL5_2)L.Decelerationsz5;
																								SELF.Decelerationsz6 := (DECIMAL5_2)L.Decelerationsz6;
																								SELF.highintensityburstnum := (DECIMAL5_2)L.highintensityburstnum;
																								SELF.highintensityburstdur := L.highintensityburstdur;
																								SELF.Sessiontype := L.Sessiontype;
																								SELF.Drillstarttime := STD.date.fromstringtotime (L.Drillstarttime[1..8], '%H:%M:%S');
																								SELF.Drilltotaltime := (DECIMAL5_2)L.Drilltotaltime;
																								SELF.Drilldistance := (DECIMAL10_5)L.Drilldistance;
																								SELF.Distancepermin := (DECIMAL5_2)L.Distancepermin;
																								SELF.Highspeeddistance := (DECIMAL5_2)L.Highspeeddistance;
																								SELF.HighspeeddistanceR := (DECIMAL5_2)L.HighspeeddistanceR;
																								SELF.AverageHR := (DECIMAL5_2)L.AverageHR;
																								SELF.timeabove85 := (DECIMAL5_2)L.timeabove85;
																								SELF.HRexertion := (DECIMAL5_2)L.HRexertion;
																								SELF.MaxHR := (DECIMAL5_2)L.MaxHR;
																								SELF.HRz1 := (DECIMAL5_2)L.HRz1;
																								SELF.sprints := (DECIMAL5_2)L.sprints;
																								SELF.Dynamicstressloadtotal := (DECIMAL5_2)L.Dynamicstressloadtotal;
																								SELF.Dynamicstressloadz1 := (DECIMAL5_2)L.Dynamicstressloadz1;
																								SELF.Dynamicstressloadz2 := (DECIMAL5_2)L.Dynamicstressloadz2;
																								SELF.Dynamicstressloadz3 := (DECIMAL5_2)L.Dynamicstressloadz3;
																								SELF.Dynamicstressloadz4 := (DECIMAL5_2)L.Dynamicstressloadz4;
																								SELF.Dynamicstressloadz5 := (DECIMAL5_2)L.Dynamicstressloadz5;
																								SELF.Dynamicstressloadz6 := (DECIMAL5_2)L.Dynamicstressloadz6;
																								SELF.totalloading := (DECIMAL5_2)L.totalloading;
																								SELF.Maxspeed := (DECIMAL5_2)L.Maxspeed;
																								SELF.Distancez6 := (DECIMAL5_2)L.Distancez6;
																								SELF.Distancez6R := (DECIMAL5_2)L.Distancez6R;
																								SELF.HSRpermin := (DECIMAL5_2)L.HSRpermin;
																								SELF.HSRperminR := (DECIMAL5_2)L.HSRperminR;
																								SELF.metabolicdis := (DECIMAL10_5)L.metabolicdis;
																								SELF.explosivedis := (DECIMAL10_5)L.explosivedis;
																								SELF.Accelerationimp := (DECIMAL5_2)L.Accelerationimp;
																								SELF.Accelerationsdisz1 := (DECIMAL5_2)L.Accelerationsdisz1;
																								SELF.Accelerationsdisz2 := (DECIMAL5_2)L.Accelerationsdisz2;
																								SELF.Accelerationsdisz3 := (DECIMAL5_2)L.Accelerationsdisz3;
																								SELF.Accelerationsdisz4 := (DECIMAL5_2)L.Accelerationsdisz4;
																								SELF.Accelerationsdisz5 := (DECIMAL5_2)L.Accelerationsdisz5;
																								SELF.Accelerationsdisz6 := (DECIMAL5_2)L.Accelerationsdisz6;
																								SELF.Decelerationsdisz1 := (DECIMAL5_2)L.Decelerationsdisz1;
																								SELF.Decelerationsdisz2 := (DECIMAL5_2)L.Decelerationsdisz2;
																								SELF.Decelerationsdisz3 := (DECIMAL5_2)L.Decelerationsdisz3;
																								SELF.Decelerationsdisz4 := (DECIMAL5_2)L.Decelerationsdisz4;
																								SELF.Decelerationsdisz5 := (DECIMAL5_2)L.Decelerationsdisz5;
																								SELF.Decelerationsdisz6 := (DECIMAL5_2)L.Decelerationsdisz6;
																								SELF.Gamedaycount := ' ';
																								SELF.daynum := 0;
																								SELF.drillnum := 0;
																								SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.MSOCgps_stgfile,
            NAME, DATE, DRILLNAME, Drillstarttime, drilltotaltime, -wuid),
        NAME, DATE, DRILLNAME, Drillstarttime, drilltotaltime
    );

mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata1 := join(finalStageData,

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := RIGHT.athleteid; SELF := LEFT;), 

left outer

);

completestgdata2 := join(completestgdata1,

Athlete360.files_stg.MSOCdate_stgfile,

left.date = right.date,

transform({RECORDOF(LEFT)}, 
				SELF.gamedaycount := RIGHT.gamedaycount;
				SELF.daynum := Right.daynum;
				SELF := LEFT;), 

left outer

);

drillnum_for_other := Athlete360.files_stg.SOCdrills_stgfile(drillname = 'other')[1].drillnum;

completestgdata3 := sort(join(completestgdata2,

Athlete360.files_stg.SOCdrills_stgfile,

Athlete360.util.toUpperTrim(left.drillname) = Athlete360.util.toUpperTrim(right.drillname),

transform({RECORDOF(LEFT), UNSIGNED1 year},
				SELF.drillnum := IF(Right.drillname = '', drillnum_for_other, Right.drillnum),
				self.year := IF(left.date > 20180000 AND left.date < 20190000, 1, IF(left.date > 20190000 AND left.date < 20200000, 2, IF(left.date > 20200000 AND left.date < 20210000, 3, 4))),
				SELF := LEFT;), 

left outer

),name,date);

// OUTPUT(drillnum_for_other);
// OUTPUT(completestgdata3);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_MSOCgps := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCgps_name, completestgData3);