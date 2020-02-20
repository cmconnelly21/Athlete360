IMPORT Athlete360, ML_Core, STD, DBSCAN;

//load data
gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);

gps1 := PROJECT(gpsdata, TRANSFORM(RECORDOF(LEFT), SELF.id := COUNTER, Self := LEFT));

//format to numericfield
ML_Core.ToField(gps1, gpsrecs);

gpsrecsf := gpsrecs(number>16);

// set up the model for analysis
Model := DBSCAN.DBSCAN().fit(gpsrecsf);

// Check how many clusters there are
NumClusters := DBSCAN.DBSCAN().Num_Clusters(Model);

// Check for outliers and label them
NumOutliers :=  DBSCAN.DBSCAN().Num_Outliers(Model);
Outliers := Model(label = 0);

// Predict the cluster index of the new samples
// Labels := DBSCAN.DBSCAN().Predict(Model, NewSamples);

// OUTPUT(gpsdata);
// OUTPUT(gps1);
OUTPUT(gpsrecsf);
OUTPUT(model);
OUTPUT(NumClusters);
OUTPUT(NumOutliers);
OUTPUT(Outliers);