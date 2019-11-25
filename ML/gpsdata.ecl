IMPORT Athlete360, STD, ML_Core;


// readinessdata := Athlete360.files_stg.MSOCreadiness_stgfile

// trainingloaddata := Athlete360.files_stg.MSOCtrainingloadNUM_stgfile

gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile;

// layout := project(rawDS1,Transform({RECORDOF(LEFT)},self := Left));


// Extended data format


gpsdataExt := project(gpsdata,Transform({RECORDOF(LEFT), UNSIGNED4 rnd := 0},self := Left)); // A random number


// Assign a random number to each record

myDataE := PROJECT(gpsdata, TRANSFORM({RECORDOF(gpsdataExt)}, SELF.rnd := RANDOM(), SELF := LEFT));

// Shuffle your data by sorting on the random field

myDataES := SORT(myDataE, rnd);


gpsTrainData := PROJECT(myDataES[1..5000], {RECORDOF(gpsdata)});  // Treat first 75% as training data.  Transform back to the original format.

gpsTestData := PROJECT(myDataES[5001..6968], {RECORDOF(gpsdata)}); // Treat next 25% as test data


//make cell-oriented data format N*M
ML_Core.ToField(gpsTrainData, gpsTrainDataNF);
ML_Core.ToField(gpsTrainData, gpsTrainDataNF);