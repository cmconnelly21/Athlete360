IMPORT Athlete360, std;
#option('outputlimit',2000);

rawDs := SORT(Athlete360.files_stg.WSOCrawgps_stgfile, name, ElapsedTime) : INDEPENDENT;

_limit := 600;
_limit2 := 1800;
_limit3 := 3000;


completegpsdata := join(dedup(sort(rawDs, name, ElapsedTime), name, ElapsedTime),

Athlete360.files_stg.WSOCgps_stgfile,

	Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND 
	trim(right.drillname) <> 'SESSION OVERALL' AND
	Left.Time BETWEEN right.drillstarttime AND 
	STD.date.AdjustTime(
			right.drillstarttime, 
			minute_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[1]), 
			second_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[2])
	),

transform({RECORDOF(LEFT), string drillname, UNSIGNED4 drillstarttime, UNSIGNED4 Date}, 
														SELF.name := RIGHT.name; 
														SELF.drillname := RIGHT.drillname;
														SELF.drillstarttime := RIGHT.drillstarttime;
														SELF.Date := RIGHT.Date;
														SELF := LEFT;), 

inner

);

inputDs := PROJECT(
        completegpsdata,
        TRANSFORM({RECORDOF(LEFT); integer cnt; 
            decimal15_8 speed_sumval := 0; 
            decimal15_8 heartrate_sumval := 0; 
            decimal10_5 speed_rollingave := 0; 
            decimal10_5 heartrate_rollingave := 0;
						decimal15_8 speed_sumval3 := 0; 
            decimal15_8 heartrate_sumval3 := 0; 
            decimal10_5 speed_rollingave3 := 0; 
            decimal10_5 heartrate_rollingave3 := 0;
						decimal15_8 speed_sumval5 := 0; 
            decimal15_8 heartrate_sumval5 := 0; 
            decimal10_5 speed_rollingave5 := 0; 
            decimal10_5 heartrate_rollingave5 := 0;
            decimal10_5 speed_boundary := 0,
            decimal10_5 heartrate_boundary := 0,
						decimal10_5 speed_boundary3 := 0,
            decimal10_5 heartrate_boundary3 := 0,
						decimal10_5 speed_boundary5 := 0,
            decimal10_5 heartrate_boundary5 := 0,
						decimal15_8 speed_sumvali := 0; 
            decimal15_8 heartrate_sumvali := 0; 
            decimal10_5 speed_rollingavei := 0; 
            decimal10_5 heartrate_rollingavei := 0;
						decimal15_8 speed_sumval3i := 0; 
            decimal15_8 heartrate_sumval3i := 0; 
            decimal10_5 speed_rollingave3i := 0; 
            decimal10_5 heartrate_rollingave3i := 0;
						decimal15_8 speed_sumval5i := 0; 
            decimal15_8 heartrate_sumval5i := 0; 
            decimal10_5 speed_rollingave5i := 0; 
            decimal10_5 heartrate_rollingave5i := 0,
						integer cnt2 := 0},
            SELF.cnt := COUNTER;
            self.speed_boundary := IF(counter < _limit, left.speed, completegpsdata[COUNTER - _limit].speed);
            self.heartrate_boundary := IF(counter < _limit, left.heartrate, completegpsdata[COUNTER - _limit].heartrate);
						self.speed_boundary3 := IF(counter < _limit2, left.speed, completegpsdata[COUNTER - _limit2].speed);
            self.heartrate_boundary3 := IF(counter < _limit2, left.heartrate, completegpsdata[COUNTER - _limit2].heartrate);
						self.speed_boundary5 := IF(counter < _limit3, left.speed, completegpsdata[COUNTER - _limit3].speed);
            self.heartrate_boundary5 := IF(counter < _limit3, left.heartrate, completegpsdata[COUNTER - _limit3].heartrate);
            SELF := LEFT;
        )
);



outputDs := ITERATE(inputDs,
    TRANSFORM({RECORDOF(LEFT)},
        self.speed_boundary := RIGHT.speed_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
        self.heartrate_boundary := RIGHT.heartrate_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
				self.speed_boundary3 := RIGHT.speed_boundary3;
        self.heartrate_boundary3 := RIGHT.heartrate_boundary3;
				self.speed_boundary5 := RIGHT.speed_boundary5;
        self.heartrate_boundary5 := RIGHT.heartrate_boundary5;
        self.cnt := RIGHT.cnt;
				self.cnt2 := IF(counter = 1 OR LEFT.name <> RIGHT.name, 1, left.cnt2 + 1);
        self.speed_sumval := IF(self.cnt = 1, 
                            RIGHT.speed, 
                            IF(self.cnt > _limit, 
                                (left.speed_sumval - self.speed_boundary), left.speed_sumval) + right.speed);
        self.heartrate_sumval := IF(self.cnt = 1, 
                            RIGHT.heartrate, 
                            IF(self.cnt > _limit, 
                                (left.heartrate_sumval - self.heartrate_boundary), left.heartrate_sumval) + right.heartrate);                                
        self.speed_rollingave := self.speed_sumval / IF(self.cnt < _limit, self.cnt, _limit);
        self.heartrate_rollingave := self.heartrate_sumval / IF(self.cnt < _limit, self.cnt, _limit);
				self.speed_sumval3 := IF(self.cnt = 1, 
                            RIGHT.speed, 
                            IF(self.cnt > _limit2, 
                                (left.speed_sumval3 - self.speed_boundary3), left.speed_sumval3) + right.speed);
        self.heartrate_sumval3 := IF(self.cnt = 1, 
                            RIGHT.heartrate, 
                            IF(self.cnt > _limit2, 
                                (left.heartrate_sumval3 - self.heartrate_boundary3), left.heartrate_sumval3) + right.heartrate);                                
        self.speed_rollingave3 := self.speed_sumval3 / IF(self.cnt < _limit2, self.cnt, _limit2);
        self.heartrate_rollingave3 := self.heartrate_sumval3 / IF(self.cnt < _limit2, self.cnt, _limit2);
				self.speed_sumval5 := IF(self.cnt = 1, 
                            RIGHT.speed, 
                            IF(self.cnt > _limit3, 
                                (left.speed_sumval5 - self.speed_boundary5), left.speed_sumval5) + right.speed);
        self.heartrate_sumval5 := IF(self.cnt = 1, 
                            RIGHT.heartrate, 
                            IF(self.cnt > _limit3, 
                                (left.heartrate_sumval5 - self.heartrate_boundary5), left.heartrate_sumval5) + right.heartrate);                                
        self.speed_rollingave5 := self.speed_sumval5 / IF(self.cnt < _limit3, self.cnt, _limit3);
        self.heartrate_rollingave5 := self.heartrate_sumval5 / IF(self.cnt < _limit3, self.cnt, _limit3);
				self.speed_sumvali := IF(self.cnt2 = 1, 
                            RIGHT.speed, 
                            IF(self.cnt2 > _limit, 
                                (left.speed_sumvali - self.speed_boundary), left.speed_sumvali) + right.speed);
        self.heartrate_sumvali := IF(self.cnt2 = 1, 
                            RIGHT.heartrate, 
                            IF(self.cnt2 > _limit, 
                                (left.heartrate_sumvali - self.heartrate_boundary), left.heartrate_sumvali) + right.heartrate);                                
        self.speed_rollingavei := self.speed_sumval / IF(self.cnt2 < _limit, self.cnt2, _limit);
        self.heartrate_rollingavei := self.heartrate_sumval / IF(self.cnt2 < _limit, self.cnt2, _limit);
				self.speed_sumval3i := IF(self.cnt2 = 1, 
                            RIGHT.speed, 
                            IF(self.cnt2 > _limit2, 
                                (left.speed_sumval3i - self.speed_boundary3), left.speed_sumval3i) + right.speed);
        self.heartrate_sumval3i := IF(self.cnt2 = 1, 
                            RIGHT.heartrate, 
                            IF(self.cnt2 > _limit2, 
                                (left.heartrate_sumval3i - self.heartrate_boundary3), left.heartrate_sumval3i) + right.heartrate);                                
        self.speed_rollingave3i := self.speed_sumval3i / IF(self.cnt2 < _limit2, self.cnt2, _limit2);
        self.heartrate_rollingave3i := self.heartrate_sumval3i / IF(self.cnt2 < _limit2, self.cnt2, _limit2);
				self.speed_sumval5i := IF(self.cnt2 = 1, 
                            RIGHT.speed, 
                            IF(self.cnt2 > _limit3, 
                                (left.speed_sumval5i - self.speed_boundary5), left.speed_sumval5i) + right.speed);
        self.heartrate_sumval5i := IF(self.cnt2 = 1, 
                            RIGHT.heartrate, 
                            IF(self.cnt2 > _limit3, 
                                (left.heartrate_sumval5i - self.heartrate_boundary5), left.heartrate_sumval5i) + right.heartrate);                                
        self.speed_rollingave5i := self.speed_sumval5i / IF(self.cnt2 < _limit3, self.cnt2, _limit3);
        self.heartrate_rollingave5i := self.heartrate_sumval5i / IF(self.cnt2 < _limit3, self.cnt2, _limit3);
        self := RIGHT
    )

);

// findpeaks := Topn(outputDs,1,drillname); 

findpeaks := dedup(sort(outputDs,drillname, -heartrate_rollingave), drillname); 

//OUTPUT(findpeaks,,'~Athlete360::OUT::Charts::WSOCGPSfindpeaks',CSV,OVERWRITE);
OUTPUT(inputDs, all);
output(outputDs, all);
output(findpeaks, all);