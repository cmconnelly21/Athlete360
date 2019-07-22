IMPORT Athlete360;
IMPORT STD;

inputData := ATHLETE360.ECLarchive.WSOC.WSOClr.File;
rec := ATHLETE360.ECLarchive.WSOC.WSOClr.layout;

inputDs := PROJECT(inputData, TRANSFORM({recordof(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));



inputDataUniqueName := DEDUP(SORT(inputData, name), name);

rec denormalizeToFindMedian(rec L, DATASET(rec) R) := TRANSFORM
     
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

inputDataWithMedians := DENORMALIZE
    (
        inputDataUniqueName, 
        inputData,
        LEFT.name = RIGHT.name,
        GROUP,
        denormalizeToFindMedian(LEFT, ROWS(RIGHT))        
    );

replaceMediansOnEmptyRecs := JOIN
    (
        inputData,
        inputDataWithMedians,
        LEFT.name = RIGHT.name,
        TRANSFORM(RECORDOF(LEFT),
            SELF.wellnesssum := IF(LEFT.wellnesssum <> 0, LEFT.wellnesssum, RIGHT.wellnesssum);
            SELF.sessionoverall := IF(LEFT.sessionoverall <> 0, LEFT.sessionoverall, RIGHT.sessionoverall);
            SELF := LEFT
        ),
        LEFT OUTER
    );

replaceMediansOnEmptyRecsProj := PROJECT
    (
        replaceMediansOnEmptyRecs, 
        TRANSFORM(
            {recordof(LEFT); integer cnt}, 
            SELF.cnt := COUNTER; 
            self := left
        )
    );

replaceMediansOnEmptyRecsWithCnt := iterate
    (
        sort
            (
                replaceMediansOnEmptyRecsProj,
                Name,_Date
            ), 
        transform(
            {rec, integer cnt}, 
            self.cnt := IF(counter = 1 OR left.name <> right.name, 1, left.cnt+ 1 ); 
            self := right
        )
    );

replaceMediansOnEmptyRecsWithCntSorted := SORT
    (
        replaceMediansOnEmptyRecsWithCnt ,
        Name,cnt
    );

dataWithAvgs := project
    (
        replaceMediansOnEmptyRecsWithCntSorted,
        Transform(
	        { Recordof(LEFT); DECIMAL5_2 SessionOverall_roll; DECIMAL5_2 WellnessSum_roll},           
  	        SELF.SessionOverall_roll2 := AVE(replaceMediansOnEmptyRecsWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt), SessionOverall);
  	        SELF.WellnessSum_roll2 := AVE(replaceMediansOnEmptyRecsWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt),WellnessSum);
						SELF.SessionOverall_roll4 := AVE(replaceMediansOnEmptyRecsWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt), SessionOverall);
  	        SELF.WellnessSum_roll4 := AVE(replaceMediansOnEmptyRecsWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt),WellnessSum);
            SELF := LEFT
        )     
    );
    
output(dataWithAvgs);

OUTPUT(ATHLETE360.ECLarchive.WSOC.WSOCdatefile.file);
OUTPUT(ATHLETE360.ECLarchive.WSOC.WSOClr.file);
OUTPUT(ATHLETE360.ECLarchive.WSOC.WSOCdatefile.processedfile);
Name := JOIN(dataWithAvgs,ATHLETE360.ECLarchive.WSOC.WSOCdatefile.file,
			STD.str.splitwords(LEFT.timestamp,' ')[1]= RIGHT.date,
			TRANSFORM({RECORDOF(LEFT); ATHLETE360.ECLarchive.WSOC.WSOCdatefile.layout.gamedaycount},
			SELF.gamedaycount := RIGHT.gamedaycount;
			SELF := LEFT));
			OUTPUT(Name, all);
			