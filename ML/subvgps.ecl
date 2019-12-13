IMPORT Athlete360, STD, ML_Core, LearningTrees;


// readinessdata := Athlete360.files_stg.MSOCreadiness_stgfile

// trainingloaddata := Athlete360.files_stg.MSOCtrainingloadNUM_stgfile

gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);
subdata := Athlete360.files_stg.MSOCreadinessNUM_stgfile;

// layout := project(rawDS1,Transform({RECORDOF(LEFT)},self := Left));


temp1 := RECORD
UNSIGNED4 athleteid;
UNSIGNED1 position;
UNSIGNED1 sessiontype;
UNSIGNED1 week;
UNSIGNED3 DayNum;
UNSIGNED3 drillname;
DECIMAL10_5 drilldistance;
DECIMAL5_2 distancepermin;
DECIMAL5_2 highspeeddistance;
DECIMAL5_2 hrexertion;
DECIMAL5_2 sprints;
DECIMAL5_2 dynamicstressloadtotal;
DECIMAL5_2 totalloading;
DECIMAL5_2 impacts;
END;


//join datasets
fulldata := join
    (
        gpsdata,
        subdata,
        left.name = right.athleteid AND 
	        Left.DayNum = Right.DayNum+1,
        transform
            ({RECORDOF(temp1), unsigned1 score, unsigned1 fatigue, unsigned1 mood, unsigned1 soreness, 
															unsigned1 stress, unsigned1 sleepquality, unsigned1 sleephours, unsigned4 time},
								SELF.athleteid := right.athleteid,
                SELF.score := right.score;
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
myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt), UNSIGNED4 id}, SELF.rnd := RANDOM(), SELF.id := COUNTER, SELF := LEFT));
// myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt)}, SELF.rnd := RANDOM(), SELF := LEFT));

// Shuffle your data by sorting on the random field
l_ML := RECORD
  UNSIGNED4 id;
  DECIMAL5_2 drilldistance;
	DECIMAL5_2 highspeeddistance;
	DECIMAL5_2 hrexertion;
	DECIMAL5_2 dynamicstressloadtotal;
	DECIMAL5_2 impacts;
  UNSIGNED2 score;
END;

myDataES := PROJECT(SORT(myDataE, rnd), TRANSFORM(l_ML, SELF := LEFT));
// myDataES := SORT(myDataE, rnd);


myTrainData := myDataES[1..920];  // Treat first 75% as training data.  Transform back to the original format.

myTestData := myDataES[920..1215]; // Treat next 25% as test data


//make cell-oriented data format N*M
ML_Core.ToField(myTrainData, myTrainDataNF);
ML_Core.ToField(myTestData, myTestDataNF);

//set independent and dependent variables
myIndTrainData := myTrainDataNF(number < 2); // Number is the field number

myDepTrainData := PROJECT(myTrainDataNF(number = 2), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));


myIndTestData := myTestDataNF(number < 7);

myDepTestData := PROJECT(myTestDataNF(number = 7), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)); //[74,75,76,77,78,79]


//set module for learningtree
myLearnerR :=  LearningTrees.RegressionForest(numTrees := 4, maxDepth := 4); // We use the default configuration parameters.  That usually works fine.

//give the model to the learningtree
myModelR := myLearnerR.GetModel(myIndTrainData, myDepTrainData);

//run prediction test
predictedDeps := myLearnerR.Predict(myModelR, myIndTestData);

//assess results
assessmentR := ML_Core.Analysis.Regression.Accuracy(predictedDeps, myDepTestData);


// OUTPUT(gpsdata,all);
// OUTPUT(subdata,all);
// OUTPUT(fulldata,all);
OUTPUT(myDataES,all);
OUTPUT(myTrainDataNF,all);
OUTPUT(myIndTrainData,all);
OUTPUT(myDepTrainData,all);
// OUTPUT(myModelR,all);
// OUTPUT(predictedDeps,all);
// OUTPUT(assessmentR,all);