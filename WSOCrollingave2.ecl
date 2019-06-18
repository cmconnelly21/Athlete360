IMPORT $;

inputData := $.WSOClr.File;

inputDs := PROJECT(inputData, TRANSFORM({recordof(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));



inputDataUniqueName := DEDUP(SORT(inputData, name), name);

rec denormalizeToFindMedian(rec L, DATASET(rec) R) := TRANSFORM
     
    SELF.welnesssum := IF(COUNT(R) % 2 = 1, 
                            SORT(R, welnesssum)[(COUNT(R) / 2 ) + 1].welnesssum, 
                            (SORT(R, welnesssum)[(COUNT(R) / 2 ) + 1].welnesssum  + SORT(R, welnesssum)[(COUNT(R) / 2)].welnesssum ) / 2
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
            SELF.welnesssum := IF(LEFT.welnesssum <> 0, LEFT.welnesssum, RIGHT.welnesssum);
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
                Name,Date
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
	        { Recordof(LEFT); DECIMAL5_2 SessionOverall_roll; DECIMAL5_2 WelnessSum_roll},           
  	        SELF.SessionOverall_roll := AVE(replaceMediansOnEmptyRecsWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-5 AND cnt <= left.cnt), SessionOverall);
  	        SELF.WelnessSum_roll := AVE(replaceMediansOnEmptyRecsWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-5 AND cnt <= left.cnt),WelnessSum);
            SELF := LEFT
        )     
    );
    
output(dataWithAvgs);