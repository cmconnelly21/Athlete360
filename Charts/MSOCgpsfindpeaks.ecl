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

rawDSsums := sort(DISTRIBUTE(Iterate(rawDs3, iterateme(LEFT, RIGHT, COUNTER)),hash64(name,date,cnt)),name,date,cnt,LOCAL);
//add fields that will be used to create the 1 min periods										
rawDSsums_limit1 := JOIN(
  rawDSsums,
  rawDSsums,
  left.name = right.name and left.date = right.date and left.cnt-600 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumspeedlimit1, integer sumhrlimit1},
      SELF.sumspeedlimit1 := IF(right.name = '', LEFT.speedsumval, LEFT.speedsumval - right.speedsumval);
      SELF.sumhrlimit1 :=  IF(right.name = '', LEFT.hrsumval, LEFT.hrsumval - right.hrsumval);
      SELF := LEFT
    ),
    LEFT OUTER,
     NOSORT,LOCAL
);
//add fields that will be used to create the 3 min periods
rawDSsums_limit3 := JOIN(
  DISTRIBUTE(rawDSsums_limit1,hash64(name,date,cnt)),
  rawDSsums,
  left.name = right.name and left.date = right.date and left.cnt -1800 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumspeedlimit3, integer sumhrlimit3},
      SELF.sumspeedlimit3 := IF(right.name = '', LEFT.speedsumval, LEFT.speedsumval - right.speedsumval);
      SELF.sumhrlimit3 :=  IF(right.name = '', LEFT.hrsumval, LEFT.hrsumval - right.hrsumval);
      SELF := LEFT
    ),
    LEFT OUTER,
     NOSORT,LOCAL
);
// add fields that will be used to create the 5 min periods
rawDSsums_limit5 := JOIN(
  DISTRIBUTE(rawDSsums_limit3,hash64(name,date,cnt)),
  rawDSsums,
  left.name = right.name and left.date = right.date and left.cnt -3000 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumspeedlimit5,integer sumhrlimit5},
      SELF.sumspeedlimit5 := IF(right.name = '', LEFT.speedsumval, LEFT.speedsumval - right.speedsumval);
      SELF.sumhrlimit5 :=  IF(right.name = '', LEFT.hrsumval, LEFT.hrsumval - right.hrsumval);
      SELF := LEFT
    ),
    LEFT OUTER,
     NOSORT,LOCAL
);
//add fields that will be used to create the averages
rawDSaves := Project(rawDSsums_limit5, 
							transform(
								{RECORDOF(LEFT), decimal10_5 speedave1, decimal10_5 speedave3, decimal10_5 speedave5, decimal10_5 hrave1,
																 decimal10_5 hrave3, decimal10_5 hrave5},
								self.speedave1 := left.sumspeedlimit1/600;
								self.hrave1 := left.sumhrlimit1/600;
								self.speedave3 := left.sumspeedlimit3/1800;
								self.hrave3 := left.sumhrlimit3/1800;
								self.speedave5 := left.sumspeedlimit5/3000;
								self.hrave5 := left.sumhrlimit5/3000;
								SELF := LEFT;
								));
// add needed fields to raw gps layout and join data from gps stage file								
temp2 := RECORD
    recordof(rawDSaves);
		string position;
    string drillname;
     UNSIGNED4 drillstarttime;
		 string gamedaycount;
		 unsigned4 week;
END;

completegpsdata := join
    (
        rawDSaves,
        Athlete360.files_stg.MSOCgps_stgfile(drillname not in ['SESSION OVERALL','SESSION OVERALL1']),
        Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name) AND 
	        trim(right.drillname) <> 'SESSION OVERALL' AND
	        trim(right.drillname) <> 'SESSION OVERALL1' AND
	        Left.date = Right.date AND
	        Std.date.FromStringToTime(Left.Time[1..8],'%H:%M:%S') BETWEEN right.drillstarttime AND 
	            STD.date.AdjustTime(
                    right.drillstarttime, 
                    minute_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[1]), 
                    second_delta := ((integer)std.str.splitwords((string)right.drilltotaltime, '.')[2])),
        transform
            ({RECORDOF(temp2)},
                SELF.name := RIGHT.name,
                SELF.athleteid := Right.athleteid,
                SELF.position := RIGHT.position,
                SELF.drillname := RIGHT.drillname,
                SELF.drillstarttime := RIGHT.drillstarttime,
								Self.gamedaycount := Right.gamedaycount,
								self.week := right.week,
                SELF.Date := RIGHT.Date,
                SELF := LEFT
            ), 
        lookup 
    );
//create dataset to show top averages for each drill during session
findpeaks := dedup(sort(DISTRIBUTE(completegpsdata, hash64(date, drillname, hrave1)), date, drillname, -hrave1, LOCAL), date, drillname, LOCAL);

//create dataset to show the peak averages for each athlete during each drill
athletespecificpeaks := dedup(sort(DISTRIBUTE(completegpsdata,hash64(date, drillname, hrave1)),name,date, drillname,drillstarttime, -hrave1, LOCAL), name,date, drillname,drillstarttime,LOCAL);

temp3 := RECORD
  string name;
  string12 time;
  decimal10_5 elapsedtime;
  decimal10_5 speed;
  unsigned3 athleteid;
	string12 position;
  string drillname;
  unsigned4 drillstarttime;
	string gamedaycount;
	unsigned4 week;
  unsigned4 date;
  decimal10_5 hrave1;
  decimal10_5 hrave3;
  decimal10_5 hrave5;
 END;
	
finalchartdata := PROJECT(athletespecificpeaks,transform({RECORDOF(temp3)}; SELF := LEFT;));

//create dataset to show average peaks for each drill 

		
// temp4 := RECORD
  // string name;
  // string12 time;
  // decimal10_5 elapsedtime;
  // decimal10_5 speed;
  // unsigned3 athleteid;
	// string12 position;
  // string drillname;
  // unsigned4 drillstarttime;
  // unsigned4 date;
	// String12 gamedaycount;
  // decimal10_5 hrave1;
  // decimal10_5 hrave3;
  // decimal10_5 hrave5;
	
 // END;		
		
// finalouput := JOIN(
  // DISTRIBUTE(finalchartdata,hash64(date)),
  // Dedup(sort(DISTRIBUTE(Athlete360.Files_stg.MSOCdate_stgfile,hash64(date)),date,LOCAL),date,LOCAL),
  // left.date = right.date,
  // transform(
      // {recordof(temp4)}, 
			// unsigned2 weeknum},
      // SELF.gamedaycount := right.gamedaycount;
			// self.weeknum := Athlete360.util.DateAddendum.YearWeekNumFromDate(left.date,2);
      // SELF := LEFT
    // ),
    // LEFT OUTER,LOCAL
// );



	
//output the data and create an output file
	
// output(rawDs3[1..1000]);
// output(rawDSsums[1..1000]);
// OUTPUT(rawDSsums_limit1[1..100]);
// OUTPUT(rawDSsums_limit3[1..100]);
// OUTPUT(rawDSsums_limit5[1..100]);
// output(completegpsdata[1..100000]);
// OUTPUT(athletespecificpeaks[1..100000]);
// OUTPUT(finalchartdata[1..100000]);
// OUTPUT(totalaverages);
// OUTPUT(finalouput[1..10000]);
// OUTPUT(finalouput);

OUTPUT(finalchartdata,,'~Athlete360::OUT::despray::MSOCGPSfindpeaks',CSV,OVERWRITE);