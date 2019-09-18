IMPORT Athlete360, std;
#option('outputlimit',2000);


//pull data from raw gps stage file
// rawDs0 := SORT(Athlete360.files_stg.MSOCrawgps_stgfile, name, date, time);
// rawDS1 := DEDUP(rawDs0, name, date, time); 
rawDS1 := Athlete360.files_stg.MSOCrawgps_stgfile;


rawDs3 := 	SORT(project(rawDS1,Transform({RECORDOF(LEFT),
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
//add fields that will be used to create the 3 min periods
rawDSsums_limit3 := JOIN(
  rawDSsums_limit1,
  rawDSsums,
  left.name = right.name and left.date = right.date, 
	// and left.cnt -1800 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumspeedlimit3, integer sumhrlimit3},
      SELF.sumspeedlimit3 := IF(right.name = '', LEFT.speedsumval, LEFT.speedsumval - right.speedsumval);
      SELF.sumhrlimit3 :=  IF(right.name = '', LEFT.hrsumval, LEFT.hrsumval - right.hrsumval);
      SELF := LEFT
    ),
    LEFT OUTER,
     LOOKUP
);
//add fields that will be used to create the 5 min periods
rawDSsums_limit5 := JOIN(
  rawDSsums_limit3,
  rawDSsums,
  left.name = right.name and left.date = right.date, 
	// and left.cnt -3000 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumspeedlimit5,integer sumhrlimit5},
      SELF.sumspeedlimit5 := IF(right.name = '', LEFT.speedsumval, LEFT.speedsumval - right.speedsumval);
      SELF.sumhrlimit5 :=  IF(right.name = '', LEFT.hrsumval, LEFT.hrsumval - right.hrsumval);
      SELF := LEFT
    ),
    LEFT OUTER,
     LOOKUP
);