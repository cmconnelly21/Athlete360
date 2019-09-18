IMPORT Athlete360, std;
#option('outputlimit',2000);


//pull data from raw gps stage file
// rawDs0 := SORT(Athlete360.files_stg.MSOCrawgps_stgfile, name, date, time);
// rawDS1 := DEDUP(rawDs0, name, date, time); 
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
        Athlete360.files_stg.MSOCgps_stgfile(drillname in ['1ST HALF','2ND HALF','1ST OT','2ND OT']),
        Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND 
					// trim(right.drillname) = '1ST HALF' AND
					// trim(right.drillname) = '2ND HALF' AND
	        Left.date = Right.date AND
	        Std.date.FromStringToTime(Left.Time[1..8],'%H:%M:%S') BETWEEN right.drillstarttime AND 
	            STD.date.AdjustTime(
                    right.drillstarttime, 
                    minute_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[1]), 
                    second_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[2])),
        transform
            ({RECORDOF(temp0)},
                SELF.name := RIGHT.name,
                SELF.athleteid := Right.athleteid,
                SELF.position := RIGHT.position,
                SELF.drillname := RIGHT.drillname,
                SELF.drillstarttime := RIGHT.drillstarttime,
                SELF.Date := RIGHT.Date,
                SELF := LEFT
            ),
						LOOKUP
    );
//create dataset to show top averages for each drill during session
// findpeaks := dedup(sort(DISTRIBUTE(completegpsdata, hash64(date, drillname, hrave1)), date, drillname, -hrave1, LOCAL), date, drillname, LOCAL);

//create dataset to show the peak averages for each athlete during each drill
// athletespecificpeaks := dedup(sort(DISTRIBUTE(completegpsdata,hash64(date, drillname, hrave1)),name,date, drillname,drillstarttime, -hrave1, LOCAL),


rawDs3 := 	SORT(project(completegpsdata,Transform({RECORDOF(LEFT),
																			Integer cnt := 0,
																			DECIMAL10_5 speedsumval := 0, 
																			Integer hrsumval := 0},
																			self := Left)), name, date, time);

// create layout and apply to build the sum fields for speed and HR
lay1 := recordof(rawDs3);

lay1 iterateme(lay1 L, lay1 R, integer cntr) := transform
										SELF.cnt := IF(cntr = 1 or L.name <> R.name or L.date <> R.date, 1, L.cnt + 1),
										self.speedsumval := IF(SELF.cnt = 1, r.speed, L.speedsumval + R.speed);
										self.hrsumval := IF(SELF.cnt = 1, r.heartrate, L.hrsumval +  r.heartrate);
										self := R;// IF(SELF.cnt = 1, R, L);
end;										

rawDSsums := Iterate(rawDs3, iterateme(LEFT, RIGHT, COUNTER));
//add fields that will be used to create the 1 min periods										
rawDSsums_limit1 := JOIN(
  rawDSsums,
  rawDSsums,
  left.name = right.name and left.date = right.date,
	// and left.cnt-600 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumspeedlimit1, integer sumhrlimit1},
      SELF.sumspeedlimit1 := IF(right.name = '', LEFT.speedsumval, LEFT.speedsumval - right.speedsumval);
      SELF.sumhrlimit1 :=  IF(right.name = '', LEFT.hrsumval, LEFT.hrsumval - right.hrsumval);
      SELF := LEFT
    ),
    LEFT OUTER,
     LOOKUP
);

// OUTPUT(rawDS1[300000..400000]);
// OUTPUT(Athlete360.files_stg.MSOCgps_stgfile(drillname='2ND HALF'));
OUTPUT(completegpsdata);
// OUTPUT(rawDSsums[300000..400000]);