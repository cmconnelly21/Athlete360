IMPORT Athlete360, STD, ML_Core, LearningTrees;


// readinessdata := Athlete360.files_stg.MSOCreadiness_stgfile

// trainingloaddata := Athlete360.files_stg.MSOCtrainingloadNUM_stgfile

gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);
subdata := Athlete360.files_stg.MSOCreadiness_stgfile;

// layout := project(rawDS1,Transform({RECORDOF(LEFT)},self := Left));

//join datasets
fulldata := join
    (
        gpsdata,
        subdata,
        left.name = right.athleteid AND 
	        Left.date = Right.date,
        transform
            ({RECORDOF(Left), unsigned1 score, unsigned1 fatigue, unsigned1 mood, unsigned1 soreness, 
															unsigned1 stress, unsigned1 sleepquality, unsigned1 sleephours, unsigned4 time},
                SELF.name := Left.name,
                SELF.score := right.score;
								SELF.fatigue := right.fatigue;
								SELF.mood := right.mood;
								SELF.soreness := right.soreness;
								SELF.stress := right.stress;
								SELF.sleepquality := right.sleepquality;
								SELF.sleephours := right.sleephours;
                SELF.Date := Left.Date,
								SELF.time := right.time;
                SELF := LEFT
            ),
						LOOKUP
    );


// Extended data format


mydataExt := project(fulldata,Transform({RECORDOF(LEFT), UNSIGNED4 rnd := 0},self := Left)); // A random number


// Assign a random number to each record

myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt)}, SELF.rnd := RANDOM(), SELF := LEFT));

// Shuffle your data by sorting on the random field

myDataES := SORT(myDataE, rnd);


myTrainData := PROJECT(myDataES[1..1000], {RECORDOF(fulldata)});  // Treat first 75% as training data.  Transform back to the original format.

myTestData := PROJECT(myDataES[1000..1280], {RECORDOF(fulldata)}); // Treat next 25% as test data


//make cell-oriented data format N*M
ML_Core.ToField(myTrainData, myTrainDataNF);
ML_Core.ToField(myTestData, myTestDataNF);

//set independent and dependent variables
myIndTrainData := myTrainDataNF(number = 10); // Number is the field number

myDepTrainData := PROJECT(myTrainDataNF(number = 73), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));


myIndTestData := myTestDataNF(number = 10);

myDepTestData := PROJECT(myTestDataNF(number = 73), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));


//set module for learningtree
myLearnerR :=  LearningTrees.RegressionForest(); // We use the default configuration parameters.  That usually works fine.

//give the model to the learningtree
myModelR := myLearnerR.GetModel(myIndTrainData, myDepTrainData);

//run prediction test
predictedDeps := myLearnerR.Predict(myModelR, myIndTestData);

//assess results
assessmentR := ML_Core.Analysis.Regression.Accuracy(predictedDeps, myDepTestData);


// OUTPUT(gpsdata,all);
// OUTPUT(subdata,all);
OUTPUT(fulldata,all);
// OUTPUT(assessmentR,all);