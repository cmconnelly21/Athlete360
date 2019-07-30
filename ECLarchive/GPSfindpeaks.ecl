IMPORT Athlete360, std;
#option('outputlimit',2000);

rawDs := SORT(Athlete360.files_stg.MSOCrawgps_stgfile, name, ElapsedTime) : INDEPENDENT;

_limit := 600;

temp1 := RECORD
    recordof(rawDs);
    string drillname;
     UNSIGNED4 drillstarttime;
      UNSIGNED4 Date;
END;
completegpsdata := join(dedup(sort(rawDs, name, ElapsedTime), name, ElapsedTime),

Athlete360.files_stg.MSOCgps_stgfile,

	Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND 
	trim(right.drillname) <> 'SESSION OVERALL' AND
	Left.Time BETWEEN right.drillstarttime AND 
	STD.date.AdjustTime(
			right.drillstarttime, 
			minute_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[1]), 
			second_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[2])
	),

transform(temp1, 
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
            decimal10_5 speed_boundary := 0,
            decimal10_5 heartrate_boundary := 0},
            SELF.cnt := COUNTER;
            self.speed_boundary := IF(counter < _limit, left.speed, completegpsdata[COUNTER - _limit].speed);
            self.heartrate_boundary := IF(counter < _limit, left.heartrate, completegpsdata[COUNTER - _limit].heartrate);
            SELF := LEFT;
        )
);

tempRec := RECORD
    temp1; 
    integer cnt; 
    decimal15_8 speed_sumval := 0; 
    decimal15_8 heartrate_sumval := 0; 
    decimal10_5 speed_rollingave := 0; 
    decimal10_5 heartrate_rollingave := 0; 
    decimal10_5 speed_boundary := 0,
    decimal10_5 heartrate_boundary := 0;
end;

temp2 := RECORD
        dataset(temprec) recs;
END;

temp2 addBoundaries(recordof(inputDs) L, DATASET(recordof(inputDs)) R) := transform
    
     SELF.recs :=  PROJECT(
        R,
        TRANSFORM(tempRec,
            SELF.cnt := COUNTER;
            self.speed_boundary := IF(counter < _limit, left.speed, R[COUNTER - _limit].speed);
            self.heartrate_boundary := IF(counter < _limit, left.heartrate, R[COUNTER - _limit].heartrate);
            SELF := LEFT;
        )
);
END;

input_boundaries := DENORMALIZE(DEDUP(SORT(inputDs, NAME), name),
        inputDs,
        LEFT.name = RIGHT.name,
        group,
        addBoundaries(LEFT, ROWS(RIGHT)));
				
temprec NewChildren(temprec R) := TRANSFORM
SELF := R;
END;
NewChilds := NORMALIZE(input_boundaries,LEFT.recs,NewChildren(RIGHT));

outputDs := ITERATE(sort(NewChilds, name, cnt),
    TRANSFORM({RECORDOF(LEFT)},
        self.speed_boundary := RIGHT.speed_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
        self.heartrate_boundary := RIGHT.heartrate_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
        self.cnt := RIGHT.cnt;
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
        self := RIGHT
    )

);

// findpeaks := Topn(outputDs,1,drillname); 

findpeaks := dedup(sort(outputDs,drillname, -heartrate_rollingave), drillname); 

//OUTPUT(findpeaks,,'~Athlete360::OUT::Charts::GPSfindpeaks',CSV,OVERWRITE);
OUTPUT(sort(NewChilds, name, cnt),all);
output(outputDs, all);
output(findpeaks, all);

athletespecificpeaks := dedup(sort(outputDs,name,drillname, -heartrate_rollingave), name,drillname);
output(athletespecificpeaks, all);