IMPORT Athlete360, STD;

gpsdata := Athlete360.files_stg.WBBgps_stgfile;

Layout := Athlete360.Layouts.WBBgpsNUM_stg;

gpsNUMdata := Project(gpsdata,transform({RECORDOF(layout)},
																								SELF.id := COUNTER;
																								SELF.date := Left.date;
																								SELF.Periodid := Left.Periodid;
																								SELF.Periodnum := (unsigned3)Left.Periodnum;
																								SELF.Forward := IF(Left.Position = 'Forward', 1, 0);
																								SELF.Guard := IF(Left.Position = 'Guard', 1, 0);
																								SELF.Center := IF(Left.Position = 'Center', 1, 0);
																								SELF.IMATotal := (UNSIGNED2)Left.IMATotal;
																								SELF.PlayerLoad := (DECIMAL5_2)Left.PlayerLoad;
																								SELF.PlayerLoadpermin:= (DECIMAL5_2)Left.PlayerLoadpermin;
																								SELF.TRIMP := (DECIMAL5_2)Left.TRIMP;
																								SELF.TRIMPpermin := (DECIMAL5_2)Left.TRIMPpermin;
																								SELF.endtime := Left.endtime;
																								SELF.starttime := Left.starttime;
																								SELF.totaltime := Left.totaltime;
																								SELF.HRover92 := (UNSIGNED4)Left.HRover92;
																								SELF.HRover85 := (UNSIGNED4)Left.HRover85;
																								SELF.HRexertion := (UNSIGNED3)Left.HRexertion;
																								SELF.MaxHR := (UNSIGNED2)Left.MaxHR;
																								SELF.exertionindex := (DECIMAL5_2)Left.exertionindex;
																								SELF.MaxAccel := (UNSIGNED2)Left.MaxAccel;
																								SELF.MaxDecel := (UNSIGNED2)Left.MaxDecel;
																								SELF.MaxVelocity := (UNSIGNED2)Left.MaxVelocity;
																								SELF.Acceldensity := (UNSIGNED2)Left.Acceldensity;
																								SELF.Acceldensityindex := (DECIMAL5_2)Left.Acceldensityindex;
																								SELF.IMAcount := (UNSIGNED2)Left.IMAcount;
																								SELF.IMAcodLmax := (UNSIGNED2)Left.IMAcodLmax;
																								SELF.IMAcodRmax := (UNSIGNED2)Left.IMAcodRmax;
																								SELF.Jumpstotal := (UNSIGNED2)Left.Jumpstotal;
																								SELF.Jumpspermin := (DECIMAL5_2)Left.Jumpspermin;
																								SELF.gamedaycount := Left.gamedaycount;
																								SELF.week := Left.week;
																								SELF.year := Left.year;
																								SELF.daynum := Left.daynum;
																								SELF.athleteid := Left.athleteid;
																								SELF.wuid := workunit;
																								SELF := LEFT
																				)
																				);
																																													 
	 
EXPORT build_WBBgpsNUM := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WBBgpsNUM_name, gpsNUMdata);