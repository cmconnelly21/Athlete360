IMPORT Athlete360;
IMPORT STD;

//pull data from readiness stage file and join with data from training loads stage file
rawDs := SORT(Athlete360.files_stg.WSOCreadiness_stgfile, Date, Name) : INDEPENDENT;

completedata := join(dedup(sort(rawDs, name), name),

Athlete360.files_stg.WSOCtrainingload_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT), Right.sessionoverall}, 
														SELF.name := RIGHT.name; 
														SELF.Date := RIGHT.Date;
														SELF.sessionoverall := Right.sessionoverall;
														SELF := LEFT;), 

left outer

);

//add count to dataset
inputDs := PROJECT(completedata, TRANSFORM({RECORDOF(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));


//define how the count will work
completedataUniqueName := DEDUP(SORT(completedata, name), name);

RECORDOF(completedata) denormalizeToFindMedian(RECORDOF(completedata) L, DATASET(RECORDOF(completedata)) R) := TRANSFORM
     
    SELF.wellnesssum := IF(COUNT(R) % 2 = 1, 
                            SORT(R, wellnesssum)[(COUNT(R) / 2 ) + 1].wellnesssum, 
                            (SORT(R, wellnesssum)[(COUNT(R) / 2 ) + 1].wellnesssum  + SORT(R, wellnesssum)[(COUNT(R) / 2)].wellnesssum ) / 2
                        );
    SELF.sessionoverall := IF(COUNT(R) % 2 = 1, 
                            SORT(R, sessionoverall)[(COUNT(R) / 2 ) + 1].sessionoverall, 
                            (SORT(R, sessionoverall)[(COUNT(R) / 2 ) + 1].sessionoverall  + SORT(R, sessionoverall)[(COUNT(R) / 2)].sessionoverall ) / 2
                        );
    
    SELF := L;

 END;

//denormalize to seperate by athlete to find median values
completedataWithMedians := DENORMALIZE
    (
        completedataUniqueName, 
        completedata,
        LEFT.name = RIGHT.name,
        GROUP,
        denormalizeToFindMedian(LEFT, ROWS(RIGHT))        
    );

//define what median values to find
replaceMediansOnEmptycompletedatas := JOIN
    (
        completedata,
        completedataWithMedians,
        LEFT.name = RIGHT.name,
        TRANSFORM(RECORDOF(LEFT),
            SELF.wellnesssum := IF(LEFT.wellnesssum <> 0, LEFT.wellnesssum, RIGHT.wellnesssum);
            SELF.sessionoverall := IF(LEFT.sessionoverall <> 0, LEFT.sessionoverall, RIGHT.sessionoverall);
            SELF := LEFT
        ),
        LEFT OUTER
    );

//add median values to dataset
replaceMediansOnEmptycompletedatasProj := PROJECT
    (
        replaceMediansOnEmptycompletedatas, 
        TRANSFORM(
            {RECORDOF(LEFT); integer cnt}, 
            SELF.cnt := COUNTER; 
            self := left
        )
    );

//add the count to the data with the median values
replaceMediansOnEmptycompletedatasWithCnt := iterate
    (
        sort
            (
                replaceMediansOnEmptycompletedatasProj,
                Name,Date
            ), 
        transform(
            {completedata, integer cnt}, 
            self.cnt := IF(counter = 1 OR left.name <> right.name, 1, left.cnt+ 1 ); 
            self := right
        )
    );
		
//sort by name
replaceMediansOnEmptycompletedatasWithCntSorted := SORT
    (
        replaceMediansOnEmptycompletedatasWithCnt ,
        Name,cnt
    );

//create and define the averages using the count to find averages based on previous 2 and 4 days
temp3 := RECORD
  unsigned4 date;
  unsigned3 time;
  string name;
  decimal5_2 wellnesssum;
  string20 athleteid;
  unsigned1 sessionoverall;
  decimal5_2 sessionoverall_roll2;
  decimal5_2 wellnesssum_roll2;
  decimal5_2 sessionoverall_roll4;
  decimal5_2 wellnesssum_roll4;
 END;


dataWithAvgs := project
    (
        replaceMediansOnEmptycompletedatasWithCntSorted,
        Transform(
	        { RECORDOF(temp3)},           
  	        SELF.sessionoverall_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt), sessionoverall);
  	        SELF.wellnesssum_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt),wellnesssum);
						SELF.sessionoverall_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt), sessionoverall);
  	        SELF.wellnesssum_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt),wellnesssum);
            SELF := LEFT
        )     
    );

//output data and create output file    
output(dataWithAvgs);

//OUTPUT(ATHLETE360.ECLarchive.WSOC.WSOCdatefile.file);
//OUTPUT(ATHLETE360.ECLarchive.WSOC.WSOClr.file);
//OUTPUT(ATHLETE360.ECLarchive.WSOC.WSOCdatefile.processedfile);
//Name := JOIN(dataWithAvgs,ATHLETE360.ECLarchive.WSOC.WSOCdatefile.file,
	//		STD.str.splitwords(LEFT.timestamp,' ')[1]= RIGHT.date,
	//		TRANSFORM({RECORDOF(LEFT); ATHLETE360.ECLarchive.WSOC.WSOCdatefile.layout.gamedaycount},
	//		SELF.gamedaycount := RIGHT.gamedaycount;
	//		SELF := LEFT));
	//		OUTPUT(Name, all);

OUTPUT(dataWithAvgs,,'~Athlete360::OUT::despray::WSOCrollingave',CSV,OVERWRITE);