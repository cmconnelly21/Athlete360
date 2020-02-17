IMPORT Athlete360, ML_Core, STD, DBScan;

//load data
gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);

//format to numericfield
ML_Core.ToField(gpsdata, gpsrecs);

// set up the model for analysis
Model := DBSCAN.DBSCAN().fit(gpsrecs(number <18));

// Check how many clusters there are
// NumClusters := DBSCAN.DBSCAN().Num_Clusters(Model);

// Check for outliers and label them
// NumOutliers :=  DBSCAN.DBSCAN().Num_Outliers(Model);
// Outliers := Model(label = 0);

// Predict the cluster index of the new samples
// Labels := DBSCAN.DBSCAN().Predict(Model, NewSamples);

OUTPUT(gpsrecs);