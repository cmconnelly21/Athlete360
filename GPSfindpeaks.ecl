IMPORT Athlete360, std;
#option('outputlimit',2000);

rawDs := SORT(Athlete360.files_stg.MSOCrawgps_stgfile, name, ElapsedTime) : INDEPENDENT;

_limit := 600;


completegpsdata := join(dedup(sort(rawDs, name, ElapsedTime), name, ElapsedTime),

Athlete360.files_stg.MSOCgps_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT), string drillname, decimal5_2 drillstarttime, UNSIGNED4 Date}, SELF.name := RIGHT.name; 
														SELF.drillname := RIGHT.drillname;
														SELF.drillstarttime := RIGHT.drillstarttime;
														SELF.Date := RIGHT.Date;
														SELF := LEFT;), 

left outer

);

inputDs := PROJECT(
        completegpsdata,
        TRANSFORM({RECORDOF(LEFT); integer cnt; 
            decimal15_8 speed_sumval := 0; 
            decimal15_8 heartrate_sumval := 0; 
            decimal10_5 speed_rollingave := 0; 
            decimal10_5 heartrate_rollingave := 0; 
            decimal10_5 speed_boundary := 0,
            decimal10_5 heartrate_boundary := 0},
            SELF.cnt := COUNTER;
            self.speed_boundary := IF(counter < _limit, left.speed, rawDs[COUNTER - _limit].speed);
            self.heartrate_boundary := IF(counter < _limit, left.heartrate, rawDs[COUNTER - _limit].heartrate);
            SELF := LEFT;
        )
);



outputDs := ITERATE(inputDs,
    TRANSFORM({RECORDOF(LEFT)},
        self.speed_boundary := RIGHT.speed_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
        self.heartrate_boundary := RIGHT.heartrate_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
        self.cnt := RIGHT.cnt;
        self.speed_sumval := IF(self.cnt = 1, 
                            RIGHT.speed, 
                            IF(self.cnt > _limit, 
                                (left.speed_sumval - self.speed_boundary), left.speed_sumval) + right.speed);
        self.heartrate_sumval := IF(self.cnt = 1, 
                            RIGHT.speed, 
                            IF(self.cnt > _limit, 
                                (left.heartrate_sumval - self.heartrate_boundary), left.heartrate_sumval) + right.heartrate);                                
        self.speed_rollingave := self.speed_sumval / IF(self.cnt < _limit, self.cnt, _limit);
        self.heartrate_rollingave := self.heartrate_sumval / IF(self.cnt < _limit, self.cnt, _limit);
        self := RIGHT
    )

);
OUTPUT(inputDs, all);
output(outputDs, all);