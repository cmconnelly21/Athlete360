IMPORT Athlete360, std;
#option('outputlimit',2000);




gpsdata := sort(Athlete360.files_stg.WBBgps_stgfile(Period in ['Pre Game','Period 1','Period 2','Period 3','Period 4','OT 1','OT 2']), date, period);

temp1 := RECORD
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
							self.PlayerLoad := AVE(group(gpsdata(date = left.date),date), PlayerLoad);
							self.PlayerLoadpermin := AVE(group(gpsdata(date = left.date),date), PlayerLoadpermin);
							self.TRIMP := AVE(group(gpsdata(date = left.date),date), TRIMP);
							self.TRIMPpermin := AVE(group(gpsdata(date = left.date),date), TRIMPpermin);
							self.MaxVelocity := AVE(group(gpsdata(date = left.date),date), MaxVelocity);
							self.IMATotal := AVE(group(gpsdata(date = left.date),date), IMATotal);
							self.IMACount := AVE(group(gpsdata(date = left.date),date), IMACount);
							self.JumpsTotal := AVE(group(gpsdata(date = left.date),date), JumpsTotal);
							self.Jumpspermin := AVE(group(gpsdata(date = left.date),date), Jumpspermin);
							self := LEFT
								)),date);



OUTPUT(gpsaverages,,'~Athlete360::OUT::charts::WBBgpsgamereport',OVERWRITE);