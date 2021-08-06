IMPORT Athlete360, STD, ML_Core, LearningTrees;


// readinessdata := Athlete360.files_stg.MSOCreadiness_stgfile

// trainingloaddata := Athlete360.files_stg.MSOCtrainingloadNUM_stgfile

gpsdata := Athlete360.Charts.WBBpracticeathletes(period = );

// layout := project(rawDS1,Transform({RECORDOF(LEFT)},self := Left));


temp1 := RECORD
UNSIGNED4 id;
UNSIGNED4 athid;
UNSIGNED1 FOR;
UNSIGNED1 CM;
UNSIGNED1 W;
UNSIGNED1 CB;
UNSIGNED1 OB;
UNSIGNED1 GK;
UNSIGNED1 Session1;
UNSIGNED1 Session2;
UNSIGNED4 date;
UNSIGNED1 week;
UNSIGNED3 DayNum;
UNSIGNED3 drillnum;
decimal5_2 z_distance;
decimal5_2 z_distpermin;
decimal5_2 z_HSdist;
decimal5_2 Z_AVEHR;
decimal5_2 z_Timeabove85;
decimal5_2 z_sprints;
decimal5_2 z_playerload;
decimal5_2 z_HSRpermin;
decimal5_2 z_impacts;
decimal5_2 z_time;
END;


subdata_newlay :=Project(SORT(subdata, athleteid, -date, -time), transform({recordof(subdata), decimal5_2 nextscore, integer cnt, DECIMAL10_5 scoresumval}, self.athleteid := left.athleteid; self := left; self := []));

newsubdata := Sort(ITERATE(
        subdata_newlay,
		transform(recordof(subdata_newlay),
						self.nextscore := left.score;
            self.score := right.score;
						self.athleteid := right.athleteid;
						self := right;
		)),athleteid,date,time
);
		

lay1 := recordof(newsubdata);

lay1 iterateme(lay1 L, lay1 R, integer cntr) := transform
										SELF.cnt := IF(cntr = 1 or L.athleteid <> R.athleteid, 1, L.cnt + 1),
										self.scoresumval := IF(SELF.cnt = 1, r.score, L.scoresumval + R.score);
										self.athleteid := R.athleteid;
										self := R;// IF(SELF.cnt = 1, R, L);
end;										

subdatasums := Iterate(newsubdata, iterateme(LEFT, RIGHT, COUNTER));

// add fields that will be used to create the 1 min periods										
subdatasums_limit1 := JOIN(
  subdatasums,
  subdatasums,
  left.athleteid = right.athleteid and left.cnt-3 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumscorelimit1},
      SELF.sumscorelimit1 := IF(left.athleteid = 0, LEFT.scoresumval, LEFT.scoresumval - right.scoresumval);
			self.athleteid := left.athleteid;
      SELF := LEFT;
    ),
    LEFT OUTER,
     LOOKUP
);

subdatasums_limit2 := JOIN(
  subdatasums_limit1,
  subdatasums,
  left.athleteid = right.athleteid and left.cnt-7 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumscorelimit2},
      SELF.sumscorelimit2 := IF(left.athleteid = 0, LEFT.scoresumval, LEFT.scoresumval - right.scoresumval);
			self.athleteid := left.athleteid;
      SELF := LEFT;
    ),
    LEFT OUTER,
     LOOKUP
);

subdatasums_limit3 := JOIN(
  subdatasums_limit2,
  subdatasums,
  left.athleteid = right.athleteid and left.cnt-14 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumscorelimit3},
      SELF.sumscorelimit3:= IF(left.athleteid = 0, LEFT.scoresumval, LEFT.scoresumval - right.scoresumval);
			self.athleteid := left.athleteid;
      SELF := LEFT;
    ),
    LEFT OUTER,
     LOOKUP
);

subdatasums_limit4 := JOIN(
  subdatasums_limit3,
  subdatasums,
  left.athleteid = right.athleteid and left.cnt-21 = right.cnt,
  transform(
      {recordof(left), decimal10_5 sumscorelimit4},
      SELF.sumscorelimit4:= IF(left.athleteid = 0, LEFT.scoresumval, LEFT.scoresumval - right.scoresumval);
			self.athleteid := left.athleteid;
      SELF := LEFT;
    ),
    LEFT OUTER,
     LOOKUP
);


subdataaves := Project(subdatasums_limit4, 
							transform(
								{RECORDOF(LEFT), decimal10_5 scoreave1, decimal10_5 scoreave2, decimal10_5 scoreave3, decimal10_5 scoreave4},
								self.scoreave1 := left.sumscorelimit1/3;
								self.scoreave2 := left.sumscorelimit2/7;
								self.scoreave3 := left.sumscorelimit3/14;
								self.scoreave4 := left.sumscorelimit4/21;
								SELF := LEFT;
								));
								


//join datasets
fulldata := join
    (
        gpsdata,
        subdataaves,
        left.athid = right.athleteid AND 
	        Left.DayNum = Right.DayNum,
        transform
            ({RECORDOF(temp1), decimal5_2 nextscore, decimal5_2 score, decimal5_2 scoreave1, decimal5_2 scoreave2, decimal5_2 scoreave3, decimal5_2 scoreave4, unsigned1 fatigue, unsigned1 mood, unsigned1 soreness, 
															unsigned1 stress, unsigned1 sleepquality, unsigned1 sleephours, unsigned4 time},
                SELF.score := right.score;
								SELF.nextscore := right.nextscore;
								SELF.scoreave1 := right.scoreave1;
								SELF.scoreave2 := right.scoreave2;
								SELF.scoreave3 := right.scoreave3;
								SELF.scoreave4 := right.scoreave4;
								SELF.fatigue := right.fatigue;
								SELF.mood := right.mood;
								SELF.soreness := right.soreness;
								SELF.stress := right.stress;
								SELF.sleepquality := right.sleepquality;
								SELF.sleephours := right.sleephours;
                SELF.DayNum := Left.DayNum,
								SELF.time := right.time;
                SELF := LEFT
            ),
						LOOKUP
    );


// Extended data format


mydataExt := project(fulldata,Transform({RECORDOF(LEFT), UNSIGNED4 rnd := 0},self := Left)); // A random number


// Assign a random number to each record
// myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt), UNSIGNED4 id}, SELF.rnd := RANDOM(), SELF.id := COUNTER, SELF := LEFT));
myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt)}, SELF.rnd := RANDOM(), SELF := LEFT));
// myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt)}, SELF.rnd := RANDOM(), SELF := LEFT));

// Shuffle your data by sorting on the random field
l_ML := RECORD
  UNSIGNED4 id;
	UNSIGNED4 athid;
  DECIMAL5_2 z_distance;
	// DECIMAL5_2 z_HSRpermin;
	DECIMAL5_2 z_Timeabove85;
	// DECIMAL5_2 z_distancepermin;
	DECIMAL5_2 z_impacts;
  UNSIGNED2 score;
	DECIMAL10_5 scoreave1;
	DECIMAL10_5 scoreave2;
	DECIMAL10_5 scoreave3;
	DECIMAL10_5 scoreave4;
	DECIMAL10_5 nextscore;
END;

myDataES := PROJECT(SORT(myDataE, rnd), TRANSFORM(l_ML, SELF := LEFT));
// myDataES := SORT(myDataE, rnd);


myTrainData := myDataES[1..915];  // Treat first 75% as training data.  Transform back to the original format.

myTestData := myDataES[915..1215]; // Treat next 25% as test data


//make cell-oriented data format N*M
ML_Core.ToField(myTrainData, myTrainDataNF);
ML_Core.ToField(myTestData, myTestDataNF);

//set independent and dependent variables
myIndTrainData := myTrainDataNF(number < 10); // Number is the field number

myDepTrainData := PROJECT(myTrainDataNF(number = 10), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));


myIndTestData := myTestDataNF(number < 10);

myDepTestData := PROJECT(myTestDataNF(number = 10), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));


//set module for learningtree
myLearnerR :=  LearningTrees.RegressionForest(numTrees := 140, maxDepth := 8); // We use the default configuration parameters.  That usually works fine.

//give the model to the learningtree
myModelR := myLearnerR.GetModel(myIndTrainData, myDepTrainData);

//run prediction test
predictedDeps := myLearnerR.Predict(myModelR, myIndTestData);

//assess results
assessmentR := ML_Core.Analysis.Regression.Accuracy(predictedDeps, myDepTestData);

importance := myLearnerR.FeatureImportance(myModelR);

				
fulldata_withprediction := Join(fulldata, predictedDeps, Left.id = right.id, transform({recordof(left), Decimal10_5 prediction},
																																							self.prediction := right.value, 
																																							self := left));


// OUTPUT(gpsdata,all);
// OUTPUT(subdata,all);
// OUTPUT(fulldata,all);
// OUTPUT(subdatasums,all);
// OUTPUT(subdataaves,all);
// OUTPUT(myDataES,all);
// OUTPUT(myTrainDataNF,all);
// OUTPUT(myIndTrainData,all);
// OUTPUT(myDepTrainData,all);
// OUTPUT(myIndTestData,all);
// OUTPUT(myDepTestData,all);
// OUTPUT(myModelR,all);
// OUTPUT(fulldata_withprediction,all);
// OUTPUT(assessmentR,all);
// OUTPUT(importance,all);
OUTPUT(fulldata_withprediction,,'~Athlete360::OUT::charts::MSOCpredictions',OVERWRITE);