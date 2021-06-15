IMPORT Athlete360, std;
#option('outputlimit',2000);


//pull data from raw gps stage file
// rawDs0 := SORT(Athlete360.files_stg.MSOCrawgps_stgfile, name, date, time);
// rawDS1 := DEDUP(rawDs0, name, date, time); 
rawDS1 := Athlete360.files_stg.WBBgps_stgfile;


filteredGps := Athlete360.files_stg.WBBgps_stgfile(Period in ['1ST HALF','2ND HALF','1ST OT','2ND OT']);

// ITERATE(
	// ,
	// TRANSFORM({RECORDOF(left); string newDrillStartTime},
		// SELF.newDrillStartTime := 
				// IF(counter = 1 or (LEFT.name <> right.name or left.date <> right.date or left.drillname = right.drillname ),
						// right.drillstarttime,
						// LEFT.drillstarttime
				// );
				


newdata := PROJECT(SORT(filteredGps, NAME, DATE, Period,TIME), 
	transform({recordof(left); unsigned3 starttime_new := 0}, self := left));
	
lay1 := recordof(newdata);
		
lay1 iterateme(lay1 L, lay1 R, integer cntr) := transform
										self.starttime_new := 
											IF(cntr = 1 or L.name <> R.name or L.date <> R.date or L.Period <> R.Period, 
													r.starttime, 
													L.starttime_new);
										self := R;// IF(SELF.cnt = 1, R, L);
end;										

rawDSsums := Iterate(newdata, iterateme(LEFT, RIGHT, COUNTER));

finalResult := PROJECT(	rawDSsums,
		transform(recordof(left), 
			self.bucketnum := Athlete360.util.get_gametimebuckets(left.starttime_new,Std.date.FromStringToTime(left.time[1..8],'%H:%M:%S'));
			SELF := LEFT
			)
		);
		
DATA_DISTANCE := SORT(
	TABLE(finalResult, 
		{name, date, Position, Period, bucketnum,
		decimal5_2 avg_speed := AVE(group, speed);
		decimal8_3 distance := AVE(group, speed) * (MAX(group, elapsedtime) - MIN(Group, elapsedtime));
		decimal8_3 time_diff :=  ((MAX(group, elapsedtime) - MIN(Group, elapsedtime))/60);
		},
		name, date, Position, Period, bucketnum,
		MERGE
		), name, date, Position, Period, bucketnum
);

// output(sort(completegpsdata(trim(name) = 'AIDAN FOSTER' and date = 20190910	and drillname = '2ND HALF' and bucketnum = 1), elapsedtime), all);




// inputDs := PROJECT(
        // completegpsdata,
        // TRANSFORM({RECORDOF(LEFT); integer cnt; 
						// decimal15_8 speedtotal := 0;
						// decimal15_8 distance := 0;
						// decimal15_2 practime := 0};
            // SELF.cnt := COUNTER;
						// self := left;
        // )
// );



// outputDs := ITERATE(inputDs,
    // TRANSFORM({RECORDOF(LEFT)},
		// self.cnt := IF(COUNTER = 1 or left.name <> RIGHT.name or left.date <> RIGHT.date or left.drillname <> RIGHT.drillname, 1, left.cnt + 1);
		// self.practime := left.cnt/10;
		// self.speedtotal := IF(self.cnt = 1, right.speed, left.speedtotal + right.speed);
		// self.distance := (left.practime * (left.speedtotal/left.cnt));
		// self := RIGHT
				
				
				
    // )

// );

// aveByBucket := table(
	// outputDs,
	// {name, date, drillname, bucketnum, avevalue :=  AVE(GROUP, distance)},
	// name, date, drillname,bucketnum	,
	// merge);
// output(sort(finalResult(trim(name) = 'AIDAN FOSTER' and date = 20190910	and drillname = '2ND HALF'), elapsedtime), all);	
// output(rawDS1);
// output(outputDs[1..100000]);
// output(Athlete360.files_stg.MSOCgps_stgfile,all);
// OUTPUT(filteredGps, all);
// output(completegpsdata);	
// output(finalResult);	
// output(DATA_DISTANCE , all);
OUTPUT(DATA_DISTANCE,,'~Athlete360::OUT::charts::MSOCgpsgamereport',OVERWRITE);