IMPORT Athlete360;
IMPORT STD;

rawDs := SORT(Athlete360.files_stg.WSOCreadiness_stgfile, Date, Name) : INDEPENDENT;

completedata := join(dedup(sort(rawDs, name), name),

Athlete360.files_stg.WSOCtrainingload_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.name := RIGHT.name; 
														SELF.Date := RIGHT.Date;
														SELF := LEFT;), 

left outer

);


inputDs := PROJECT(completedata, TRANSFORM({RECORDOF(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));



completedataUniqueName := DEDUP(SORT(completedata, name), name);

completedata denormalizeToFindMedian(completedata L, DATASET(completedata) R) := TRANSFORM
     
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

completedataWithMedians := DENORMALIZE
    (
        completedataUniqueName, 
        completedata,
        LEFT.name = RIGHT.name,
        GROUP,
        denormalizeToFindMedian(LEFT, ROWS(RIGHT))        
    );

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

replaceMediansOnEmptycompletedatasProj := PROJECT
    (
        replaceMediansOnEmptycompletedatas, 
        TRANSFORM(
            {RECORDOF(LEFT); integer cnt}, 
            SELF.cnt := COUNTER; 
            self := left
        )
    );

replaceMediansOnEmptycompletedatasWithCnt := iterate
    (
        sort
            (
                replaceMediansOnEmptycompletedatasProj,
                Name,_Date
            ), 
        transform(
            {completedata, integer cnt}, 
            self.cnt := IF(counter = 1 OR left.name <> right.name, 1, left.cnt+ 1 ); 
            self := right
        )
    );

replaceMediansOnEmptycompletedatasWithCntSorted := SORT
    (
        replaceMediansOnEmptycompletedatasWithCnt ,
        Name,cnt
    );

dataWithAvgs := project
    (
        replaceMediansOnEmptycompletedatasWithCntSorted,
        Transform(
	        { RECORDOF(LEFT); DECIMAL5_2 SessionOverall_roll; DECIMAL5_2 WellnessSum_roll},           
  	        SELF.SessionOverall_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt), SessionOverall);
  	        SELF.WellnessSum_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt),WellnessSum);
						SELF.SessionOverall_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt), SessionOverall);
  	        SELF.WellnessSum_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt),WellnessSum);
            SELF := LEFT
        )     
    );
    
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
			