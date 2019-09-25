IMPORT Athlete360, std;
#option('outputlimit',2000);


rawDS1 := Athlete360.files_stg.MSOCrawgps_stgfile;


temp0 := RECORD
    recordof(rawDS1);
		string position;
    string drillname;
     UNSIGNED4 drillstarttime;
END;

completegpsdata := join
    (
        rawDS1,
        Athlete360.files_stg.MSOCgps_stgfile(drillname not in ['SESSION OVERALL','SESSION OVERALL1']),
        Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND 
	        Left.date = Right.date AND
	        Std.date.FromStringToTime(Left.Time[1..8],'%H:%M:%S') BETWEEN right.drillstarttime AND 
	            STD.date.AdjustTime(
                    right.drillstarttime, 
                    minute_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[1]), 
                    second_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[2])),
        transform
            ({RECORDOF(Left), string position, string drillname, UNSIGNED4 drillstarttime},
                SELF.name := RIGHT.name,
                SELF.athleteid := Right.athleteid,
                SELF.position := RIGHT.position,
                SELF.drillname := RIGHT.drillname,
                SELF.drillstarttime := RIGHT.drillstarttime,
                SELF.Date := RIGHT.Date,
								SELF.time := Left.time;
                SELF := LEFT
            ),
						LOOKUP
    );




DATA_DISTANCE := SORT(
	TABLE(completegpsdata, 
		{name, date, drillname,
		decimal5_2 avg_speed := AVE(group, speed);
		decimal8_3 distance := AVE(group, speed) * (MAX(group, elapsedtime) - MIN(Group, elapsedtime));
		},
		name, date, drillname,
		MERGE
		), name, date, drillname
);		
		
		
// output(DATA_DISTANCE , all);		

OUTPUT(DATA_DISTANCE,,'~Athlete360::OUT::despray::MSOCGPSdistance',CSV,OVERWRITE);