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

gpsdata1 := PROJECT(gpsdata,TRANSFORM({RECORDOF(temp1)}, self := left));

// gpsdata2 := GROUP(gpsdata1,athid);

// DATA_AVE := SORT(
	// TABLE(gpsdata1, 
		// {athid, Date,
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
		// athid, Date,
		// MERGE
		// ), athid
// );

DATA_AVE_ID := SORT(
	TABLE(gpsdata1, 
		{athid,
		decimal5_2 avg_distance := AVE(group, drilldistance);
		decimal5_2 avg_distpermin := AVE(group,distancepermin);
		decimal5_2 avg_HSdist := AVE(group,highspeeddistance);
		decimal5_2 avg_AVEHR := AVE(group,AverageHR);
		decimal5_2 avg_Timeabove85 := AVE(group,Timeabove85);
		decimal5_2 avg_sprints := AVE(group,sprints);
		decimal5_2 avg_playerload := AVE(group,dynamicstressloadtotal);
		decimal5_2 avg_HSRpermin := AVE(group,HSRpermin);
		decimal5_2 avg_impacts := AVE(group,impacts);
		decimal5_2 avg_time := AVE(group,drilltotaltime);
		},
		athid,
		MERGE
		), athid
);

New_layout := RECORD
decimal5_2 z_distance;
decimal5_2 z_distpermin;
decimal5_2 z_HSdist;
decimal5_2 Z_AVEHR;
decimal5_2 z_Timeabove85;
decimal5_2 z_sprints;
decimal5_2 z_playerload;
decimal5_2 z_HSRpermin;
decimal5_2 z_impacts;
decimal5_2 z_time;
END;


Finaldata := join(gpsdata1, DATA_AVE_ID,
									Left.athid = Right.athid,
									Transform(New_layout,
														Self.z_distance := left.Drilldistance-right.avg_distance,
														Self.z_distpermin := left.distancepermin-right.avg_distpermin,
														Self.z_HSdist := left.highspeeddistance-right.avg_HSdist,
														Self.z_AVEHR := left.AverageHR-right.avg_AVEHR,
														Self.z_Timeabove85 := left.Timeabove85-right.avg_timeabove85,
														Self.z_sprints := left.sprints-right.avg_sprints,
														Self.z_playerload := left.dynamicstressloadtotal-right.avg_playerload,
														Self.z_HSRpermin := left.HSRpermin-right.avg_HSRpermin,
														Self.z_impacts := left.impacts-right.avg_impacts,
														Self.z_time := left.drilltotaltime-right.avg_time
														),
														INNER,
														);



OUTPUT(gpsdata1);
OUTPUT(DATA_AVE_ID);
OUTPUT(finaldata);