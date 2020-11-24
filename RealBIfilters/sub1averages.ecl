import athlete360;

datafile := Athlete360.files_stg.MSOCreadinessNUM_stgfile;
datafile2 := Athlete360.files_stg.MSOCtrainingloadNUM_stgfile;

subdata := sort(datafile, athid, date, drillname);

temp1 := RECORD
  unsigned4 athid;
  unsigned4 date;
  unsigned4 drillname;
	decimal10_5 drilldistanceave;
	decimal10_5 distperminave;
	decimal10_5 highspeedave;
	decimal10_5 timeabove85ave;
	decimal10_5 sprintsave;
	decimal10_5 impactsave;
	decimal10_5 playerloadave;
 END; 
 
 sub1averages := Project(gpsdata, 
							transform({RECORDOF(temp1)},
							self.drilldistanceave := AVE(group(gpsdata(drillname = left.drillname),drillname), drilldistance);
							self.distperminave := AVE(group(gpsdata(drillname = left.drillname),drillname), distancepermin);
							self.highspeedave := AVE(group(gpsdata(drillname = left.drillname),drillname), highspeeddistance);
							self.timeabove85ave := AVE(group(gpsdata(drillname = left.drillname),drillname), timeabove85);
							self.sprintsave := AVE(group(gpsdata(drillname = left.drillname),drillname), sprints);
							self.impactsave := AVE(group(gpsdata(drillname = left.drillname),drillname), impacts);
							self.playerloadave := AVE(group(gpsdata(drillname = left.drillname),drillname), dynamicstressloadtotal);
							self := LEFT
								));
								
OUTPUT(sub1averages);