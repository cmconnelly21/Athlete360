IMPORT Athlete360, std;
#option('outputlimit',2000);

//pull data from raw gps stage file
rawDs := SORT(Athlete360.files_stg.MSOCrawgps_stgfile, name, date, ElapsedTime, time) : INDEPENDENT;

//set window size for different time periods, 10 rows = 1 second
_limit := 600;
_limit2 := 1800;
_limit3 := 3000;

//add needed fields to raw gps layout and join data from gps stage file
temp1 := RECORD
    recordof(rawDs);
		string position;
    string drillname;
     UNSIGNED4 drillstarttime;
END;
completegpsdata := join(dedup(sort(rawDs, name, date, ElapsedTime, time), name, date, ElapsedTime, time),

Athlete360.files_stg.MSOCgps_stgfile,

	Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND 
	trim(right.drillname) <> 'SESSION OVERALL' AND
	Left.date = Right.date AND
	Left.Time BETWEEN right.drillstarttime AND 
	STD.date.AdjustTime(
			right.drillstarttime, 
			minute_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[1]), 
			second_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[2])
	),

transform(temp1, 
														SELF.name := RIGHT.name;
														SELF.athleteid := Right.athleteid;
														SELF.position := RIGHT.position;
														SELF.drillname := RIGHT.drillname;
														SELF.drillstarttime := RIGHT.drillstarttime;
														SELF.Date := RIGHT.Date;
														SELF := LEFT;), 

left outer, SMART

);

//add needed fields to complete gps data and build boundaries to create the time period windows
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

//add fields that will be used to create the averages
tempRec := RECORD
    temp1; 
    integer cnt; 
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
    decimal10_5 heartrate_boundary := 0;
		decimal10_5 speed_boundary3 := 0,
    decimal10_5 heartrate_boundary3 := 0,
		decimal10_5 speed_boundary5 := 0,
    decimal10_5 heartrate_boundary5 := 0,
end;

temp2 := RECORD
        dataset(temprec) recs;
END;

//add the boundaries to the new layout and define how they will work
temp2 addBoundaries(recordof(inputDs) L, DATASET(recordof(inputDs)) R) := transform
    
     SELF.recs :=  PROJECT(
        R,
        TRANSFORM(tempRec,
            SELF.cnt := COUNTER;
            self.speed_boundary := IF(counter < _limit, left.speed, R[COUNTER - _limit].speed);
            self.heartrate_boundary := IF(counter < _limit, left.heartrate, R[COUNTER - _limit].heartrate);
						self.speed_boundary3 := IF(counter < _limit2, left.speed, R[COUNTER - _limit2].speed);
            self.heartrate_boundary3 := IF(counter < _limit2, left.heartrate, R[COUNTER - _limit2].heartrate);
						self.speed_boundary5 := IF(counter < _limit3, left.speed, R[COUNTER - _limit3].speed);
            self.heartrate_boundary5 := IF(counter < _limit3, left.heartrate, R[COUNTER - _limit3].heartrate);
            SELF := LEFT;
        )
);
END;

//denormalize and set data up to seperate the data by athlete
input_boundaries := DENORMALIZE(DEDUP(SORT(inputDs, NAME), name),
        inputDs,
        LEFT.name = RIGHT.name,
        group,
        addBoundaries(LEFT, ROWS(RIGHT)));
				
temprec NewChildren(temprec R) := TRANSFORM
SELF := R;
END;
NewChilds := NORMALIZE(input_boundaries,LEFT.recs,NewChildren(RIGHT));

//go through by row and set the boundaries and cnt that will be created for each athlete, then layout sum and averages fields
outputDs := ITERATE(sort(NewChilds, name, cnt),
    TRANSFORM({RECORDOF(LEFT)},
        self.speed_boundary := RIGHT.speed_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
        self.heartrate_boundary := RIGHT.heartrate_boundary;//IF(COUNTER < _limit, right.speed, left.speed);
				self.speed_boundary3 := RIGHT.speed_boundary3;
        self.heartrate_boundary3 := RIGHT.heartrate_boundary3;
				self.speed_boundary5 := RIGHT.speed_boundary5;
        self.heartrate_boundary5 := RIGHT.heartrate_boundary5;
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
        self := RIGHT
    )

);

//create dataset to show top averages for each drill during session
// findpeaks := Topn(outputDs,1,drillname); 

findpeaks := dedup(sort(DISTRIBUTE(outputDs, hash64(drillname, heartrate_rollingave)), drillname, -heartrate_rollingave, LOCAL), drillname, LOCAL);

//create dataset to show the peak averages for each athlete during each drill
athletespecificpeaks := dedup(sort(outputDs,name,drillname, -heartrate_rollingave), name,drillname);

//create dataset to show average peaks for each drill 
temp3 := RECORD
  string name;
  unsigned4 time;
  decimal10_5 elapsedtime;
  decimal10_5 speed;
  unsigned3 heartrate;
  string20 athleteid;
  string drillname;
  unsigned4 drillstarttime;
  unsigned4 date;
  decimal10_5 speed_rollingave;
  decimal10_5 heartrate_rollingave;
  decimal10_5 speed_rollingave3;
  decimal10_5 heartrate_rollingave3;
  decimal10_5 speed_rollingave5;
  decimal10_5 heartrate_rollingave5;
 END; 

totalaverages := Project(athletespecificpeaks, 
							transform({RECORDOF(temp3);
								decimal5_2 heartrate_totalave,
								decimal5_2 heartrate_totalave3,
								decimal5_2 heartrate_totalave5},
							self.heartrate_totalave := AVE(group(athletespecificpeaks(drillname = left.drillname),drillname), heartrate_rollingave);
							self.heartrate_totalave3 := AVE(group(athletespecificpeaks(drillname = left.drillname),drillname), heartrate_rollingave3);
							self.heartrate_totalave5 := AVE(group(athletespecificpeaks(drillname = left.drillname),drillname), heartrate_rollingave5);
							self := LEFT
								));
								
//output the data and create an output file								


OUTPUT(totalaverages,,'~Athlete360::OUT::despray::MSOCgpsfindpeaks',CSV,OVERWRITE);