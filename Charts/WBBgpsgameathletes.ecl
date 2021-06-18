IMPORT Athlete360, std;
#option('outputlimit',2000);




gpsdata := sort(Athlete360.files_stg.WBBgps_stgfile(Period in ['Pre Game','Period 1','Period 2','Period 3','Period 4','OT 1','OT 2']), athleteid, date, period);

temp1 := RECORD
  unsigned2 athleteid;
	unsigned4 date;
	unsigned4 daynum;
  string period;
	decimal10_5 PlayerLoad;
	decimal10_5 PlayerLoadpermin;
	decimal10_5 TRIMP;
	decimal10_5 TRIMPpermin;
	unsigned4 MaxVelocity;
	unsigned4 IMATotal;
	unsigned4 IMACount;
	unsigned4 JumpsTotal;
	decimal10_5 Jumpspermin;
 END; 
 
 gpsaverages := sort(Project(gpsdata, 
							transform({RECORDOF(temp1)},
							self.PlayerLoad := AVE(group(gpsdata,athleteid,date,period), PlayerLoad);
							self.PlayerLoadpermin := AVE(group(gpsdata,athleteid,date,period), PlayerLoadpermin);
							self.TRIMP := AVE(group(gpsdata,athleteid,date,period), TRIMP);
							self.TRIMPpermin := AVE(group(gpsdata,athleteid,date,period), TRIMPpermin);
							self.MaxVelocity := AVE(group(gpsdata,athleteid,date,period), MaxVelocity);
							self.IMATotal := AVE(group(gpsdata,athleteid,date,period), IMATotal);
							self.IMACount := AVE(group(gpsdata,athleteid,date,period), IMACount);
							self.JumpsTotal := AVE(group(gpsdata,athleteid,date,period), JumpsTotal);
							self.Jumpspermin := AVE(group(gpsdata,athleteid,date,period), Jumpspermin);
							self := LEFT
								)),athleteid, date, period);


OUTPUT(gpsdata);
OUTPUT(gpsaverages);
// OUTPUT(gpsaverages,,'~Athlete360::OUT::charts::WBBgpsgameathletes',OVERWRITE);