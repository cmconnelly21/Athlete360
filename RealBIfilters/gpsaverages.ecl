import athlete360;

datafile := Athlete360.files_stg.MSOCgpsNUM_stgfile;

gpsdata := sort(datafile(drillname=116), athid, date, drillname);

temp1 := RECORD
  unsigned4 date;
	unsigned4 week;
  unsigned4 drillname;
	decimal10_5 drilldistanceave;
	decimal10_5 distperminave;
	decimal10_5 highspeedave;
	decimal10_5 timeabove85ave;
	decimal10_5 sprintsave;
	decimal10_5 impactsave;
	decimal10_5 playerloadave;
 END; 
 
 gpsaverages := dedup(sort(Project(gpsdata, 
							transform({RECORDOF(temp1)},
							self.drilldistanceave := AVE(group(gpsdata(date = left.date),date), drilldistance);
							self.distperminave := AVE(group(gpsdata(date = left.date),date), distancepermin);
							self.highspeedave := AVE(group(gpsdata(date = left.date),date), highspeeddistance);
							self.timeabove85ave := AVE(group(gpsdata(date = left.date),date), timeabove85);
							self.sprintsave := AVE(group(gpsdata(date = left.date),date), sprints);
							self.impactsave := AVE(group(gpsdata(date = left.date),date), impacts);
							self.playerloadave := AVE(group(gpsdata(date = left.date),date), dynamicstressloadtotal);
							self := LEFT
								)),date),date);
								
OUTPUT(gpsaverages,,'~Athlete360::OUT::Charts::gpsaverages',OVERWRITE);