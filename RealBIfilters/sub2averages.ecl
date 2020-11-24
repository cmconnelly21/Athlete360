import athlete360;

datafile := Athlete360.files_stg.MSOCtrainingloadNUM_stgfile;
gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile;

subdata := sort(datafile, athleteid, date);


sub2data := join(subdata,gpsdata,(integer)left.name = right.athid AND left.date = right.date,transform({subdata, unsigned4 week},
																																				self.week := right.week,
																																				self := left), LOOKUP);

temp1 := RECORD
  unsigned4 date;
	unsigned4 week;
  unsigned4 trainingloadave;
 END; 
 
 sub2averages := dedup(sort(Project(sub2data, 
							transform({RECORDOF(temp1)},
							self.trainingloadave := AVE(group(sub2data(date = left.date),date), trainingload);
							self := LEFT
								)),date),date);
								
OUTPUT(sub2averages,,'~Athlete360::OUT::Charts::sub2averages',OVERWRITE);
// OUTPUT(subdata);
// OUTPUT(sub2data);