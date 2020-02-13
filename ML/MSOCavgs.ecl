IMPORT Athlete360, STD;

gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);

temp1 := RECORD
UNSIGNED4 id;
UNSIGNED4 athid;
UNSIGNED1 FOR;
UNSIGNED1 CM;
UNSIGNED1 CAM;
UNSIGNED1 CDM;
UNSIGNED1 WM;
UNSIGNED1 FB;
UNSIGNED1 OB;
UNSIGNED1 GK;
UNSIGNED1 Session1;
UNSIGNED1 Session2;
UNSIGNED1 week;
UNSIGNED3 DayNum;
UNSIGNED3 drillname;
DECIMAL10_5 drilldistance;
DECIMAL5_2 distancepermin;
DECIMAL5_2 highspeeddistance;
DECIMAL5_2 AverageHR;
DECIMAL5_2 Timeabove85;
DECIMAL5_2 sprints;
DECIMAL5_2 dynamicstressloadtotal;
DECIMAL5_2 HSRpermin;
DECIMAL5_2 impacts;
DECIMAL5_2 Drilltotaltime;
END;

gpsdata1 := SORT(PROJECT(gpsdata,TRANSFORM({RECORDOF(temp1)}, self := left)),athid);

gpsdata2 := GROUP(gpsdata1,athid);

DATA_AVE := PROJECT(gpsdata2,TRANSFORM
		({RECORDOF(gpsdata2), decimal5_2 ave_distance, decimal5_2 ave_distpermin, decimal5_2 ave_HSdist, decimal5_2 ave_AVEHR, 
		decimal5_2 ave_timeabove85, decimal5_2 ave_sprints, decimal5_2 ave_playerload, decimal5_2 ave_HSRpermin, 
		decimal5_2 ave_impacts, decimal5_2 ave_time},
				Self.ave_distance := AVE(drilldistance);
				Self.ave_distpermin := AVE(distancepermin);
				Self.ave_HSdist := AVE(highspeeddistance);
				Self.ave_AVEHR := AVE(AverageHR);
				Self.ave_Timeabove85 := AVE(Timeabove85);
				Self.ave_sprints := AVE(sprints);
				Self.ave_playerload := AVE(dynamicstressloadtotal);
				Self.ave_HSRpermin := AVE(HSRpermin);
				Self.ave_impacts := AVE(impacts);
				Self.ave_time := AVE(drilltotaltime);
				Self := Left;
			));

// DATA_AVE := SORT(
	// TABLE(gpsdata1, 
		// {athid,
		// decimal5_2 avg_distance := AVE(group, drilldistance);
		// decimal5_2 avg_distpermin := AVE(group,distancepermin);
		// decimal5_2 avg_HSdist := AVE(group,highspeeddistance);
		// decimal5_2 avg_AVEHR := AVE(group,AverageHR);
		// decimal5_2 avg_Timeabove85 := AVE(group,Timeabove85);
		// decimal5_2 avg_sprints := AVE(group,sprints);
		// decimal5_2 avg_playerload := AVE(group,dynamicstressloadtotal);
		// decimal5_2 avg_HSRpermin := AVE(group,HSRpermin);
		// decimal5_2 avg_impacts := AVE(group,impacts);
		// decimal5_2 avg_time := AVE(group,drilltotaltime);
		// },
		// athid,
		// MERGE,
		// ), athid
// );

// DATA_FINAL := SORT(
	// TABLE(DATA_AVE, 
		// {athid,
		// decimal5_2 z_distance := drilldistance/ave_distance;
		// decimal5_2 z_distpermin := distancepermin/ave_distpermin;
		// decimal5_2 z_HSdist := highspeeddistance/ave_HSdist;
		// decimal5_2 z_AVEHR := AverageHR/ave_AVEHR;
		// decimal5_2 z_Timeabove85 := Timeabove85/ave_timeabove85;
		// decimal5_2 z_sprints := sprints/ave_sprints;
		// decimal5_2 z_playerload := dynamicstressloadtotal/ave_playerload;
		// decimal5_2 z_HSRpermin := HSRpermin/ave_HSRpermin;
		// decimal5_2 z_impacts := impacts/ave_impacts;
		// decimal5_2 z_time := drilltotaltime/ave_time;
		// },
		// athid,
		// MERGE
		// ), athid
// );


OUTPUT(gpsdata1);
OUTPUT(DATA_AVE);
// OUTPUT(DATA_FINAL);