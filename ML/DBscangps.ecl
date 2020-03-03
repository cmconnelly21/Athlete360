IMPORT Athlete360, ML_Core, STD, DBSCAN;

//load data
gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);

gps1 := PROJECT(gpsdata, TRANSFORM(RECORDOF(LEFT), SELF.id := COUNTER, Self := LEFT));

//format to numericfield
ML_Core.ToField(gps1, gpsrecs);

gpsrecsf := gpsrecs(number>16);
gps2 := PROJECT(gpsrecsf, TRANSFORM(RECORDOF(LEFT), SELF.number := LEFT.number -16, Self := LEFT));

// set up the model for analysis
Model := DBSCAN.DBSCAN(eps := 1200.0, minPts := 3).fit(gps2);

// Check how many clusters there are
NumClusters := DBSCAN.DBSCAN(eps := 1200.0, minPts := 3).Num_Clusters(Model);

// Check for outliers and label them
NumOutliers :=  DBSCAN.DBSCAN(eps := 1200.0, minPts := 3).Num_Outliers(Model);
Outliers := Model(label = 0);

// Predict the cluster index of the new samples
// Labels := DBSCAN.DBSCAN(eps := 1000.0, minPts := 3).Predict(Model, NewSamples);

// OUTPUT(gpsdata, ALL, NAMED('gpsdata'));
// OUTPUT(gps1, ALL, NAMED('gps1'));
OUTPUT(gps2, ALL, NAMED('gps2'));
OUTPUT(model, ALL, NAMED('model'));
OUTPUT(NumClusters, ALL, NAMED('NumClusters'));
OUTPUT(NumOutliers, ALL, NAMED('NumOutliers'));
OUTPUT(Outliers, ALL, NAMED('Outliers'));