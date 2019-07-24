IMPORT Athlete360;
IMPORT STD;

rawDs := SORT(Athlete360.files_stg.MSOCreadiness_stgfile, Date, Name) : INDEPENDENT;

completedata := join(dedup(sort(rawDs, name), name),

Athlete360.files_stg.MSOCtrainingload_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT), Right.trainingload}, 
														SELF.name := RIGHT.name; 
														SELF.Date := RIGHT.Date;
														SELF.trainingload := Right.trainingload;
														SELF := LEFT;), 

left outer

);


inputDs := PROJECT(completedata, TRANSFORM({RECORDOF(LEFT); integer cnt}, SELF.cnt := COUNTER; self := left));



completedataUniqueName := DEDUP(SORT(completedata, name), name);

RECORDOF(completedata) denormalizeToFindMedian(RECORDOF(completedata) L, DATASET(RECORDOF(completedata)) R) := TRANSFORM
     
    SELF.score := IF(COUNT(R) % 2 = 1, 
                            SORT(R, score)[(COUNT(R) / 2 ) + 1].score, 
                            (SORT(R, score)[(COUNT(R) / 2 ) + 1].score  + SORT(R, score)[(COUNT(R) / 2)].score ) / 2
                        );
    SELF.TrainingLoad := IF(COUNT(R) % 2 = 1, 
                            SORT(R, TrainingLoad)[(COUNT(R) / 2 ) + 1].TrainingLoad, 
                            (SORT(R, TrainingLoad)[(COUNT(R) / 2 ) + 1].TrainingLoad  + SORT(R, TrainingLoad)[(COUNT(R) / 2)].TrainingLoad ) / 2
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
            SELF.score := IF(LEFT.score <> 0, LEFT.score, RIGHT.score);
            SELF.TrainingLoad := IF(LEFT.TrainingLoad <> 0, LEFT.TrainingLoad, RIGHT.TrainingLoad);
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
                Name,Date
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
	        { RECORDOF(LEFT); DECIMAL5_2 TrainingLoad_roll2; DECIMAL5_2 score_roll2; DECIMAL5_2 TrainingLoad_roll4; DECIMAL5_2 score_roll4},           
  	        SELF.TrainingLoad_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt), TrainingLoad);
  	        SELF.score_roll2 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-2 AND cnt <= left.cnt),score);
						SELF.TrainingLoad_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt), TrainingLoad);
  	        SELF.score_roll4 := AVE(replaceMediansOnEmptycompletedatasWithCntSorted(name = LEFT.name AND cnt > LEFT.cnt-4 AND cnt <= left.cnt),score);
            SELF := LEFT
        )     
    );
    
output(dataWithAvgs);

//OUTPUT(ATHLETE360.ECLarchive.MSOC.MSOCdatefile.file);
//OUTPUT(ATHLETE360.ECLarchive.MSOC.MSOClr.file);
//OUTPUT(ATHLETE360.ECLarchive.MSOC.MSOCdatefile.processedfile);
//Name := JOIN(dataWithAvgs,ATHLETE360.ECLarchive.MSOC.MSOCdatefile.file,
	//		STD.str.splitwords(LEFT.timestamp,' ')[1]= RIGHT.date,
	//		TRANSFORM({RECORDOF(LEFT); ATHLETE360.ECLarchive.MSOC.MSOCdatefile.layout.gamedaycount},
	//		SELF.gamedaycount := RIGHT.gamedaycount;
	//		SELF := LEFT));
	//		OUTPUT(Name, all);

OUTPUT(dataWithAvgs,,'~Athlete360::OUT::Charts::MSOCrollingave',CSV,OVERWRITE);