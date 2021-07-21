IMPORT Athlete360, std;
#option('outputlimit',2000);




gpsdata := sort(Athlete360.files_stg.WBBgps_stgfile(Period in ['Pre Game Warm Up','Period 1','Period 2','Period 3','Period 4','Quarter 1','Quarter 2','Quarter 3','Quarter 4','OT 1','OT 2']), athleteid, date, period);

temp1 := RECORD
  unsigned2 athleteid;
	unsigned4 date;
	unsigned4 week;
	unsigned1 year;
	unsigned4 daynum;
  string period;
	unsigned4 starttime;
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
 

gpsdata1 := PROJECT(gpsdata,TRANSFORM({RECORDOF(temp1)}, self := left));


DATA_AVE_ID := SORT(
	TABLE(gpsdata1, 
		{athleteid,date,period,
		decimal10_5 ave_PlayerLoad := AVE(group, PlayerLoad);
		decimal10_5 ave_PlayerLoadpermin := AVE(group, PlayerLoadpermin);
		decimal10_5 ave_TRIMP := AVE(group, TRIMP);
		decimal10_5 ave_TRIMPpermin := AVE(group, TRIMPpermin);
		unsigned4 ave_MaxVelocity := AVE(group, MaxVelocity);
		unsigned4 ave_IMATotal := AVE(group, IMATotal);
		unsigned4 ave_IMACount := AVE(group, IMACount);
		unsigned4 ave_JumpsTotal := AVE(group, JumpsTotal);
		decimal10_5 ave_Jumpspermin := AVE(group, Jumpspermin);
		},
		athleteid,date,period,
		MERGE
		), athleteid,date,period
	);

temp2 := RECORD
  unsigned2 athleteid;
	unsigned4 date;
	unsigned4 week;
	unsigned1 year;
	unsigned4 daynum;
  string period;
	unsigned4 starttime;
	decimal10_5 ave_PlayerLoad;
	decimal10_5 ave_PlayerLoadpermin;
	decimal10_5 ave_TRIMP;
	decimal10_5 ave_TRIMPpermin;
	unsigned4 ave_MaxVelocity;
	unsigned4 ave_IMATotal;
	unsigned4 ave_IMACount;
	unsigned4 ave_JumpsTotal;
	decimal10_5 ave_Jumpspermin;
 END; 
 
 
gpsaverages := sort(join(gpsdata1, DATA_AVE_ID,
									Left.athleteid = Right.athleteid AND left.date = right.date AND left.period = right.period,
									Transform(temp2,
														self.ave_playerload := right.ave_playerload;
														self.ave_playerloadpermin := right.ave_playerloadpermin;
														self.ave_trimp := right.ave_trimp;
														self.ave_trimppermin := right.ave_trimppermin;
														self.ave_maxvelocity := right.ave_maxvelocity;
														self.ave_imatotal := right.ave_imatotal;
														self.ave_imacount := right.ave_imacount;
														self.ave_jumpstotal := right.ave_jumpstotal;
														self.ave_jumpspermin := right.ave_jumpspermin;
														Self := Left;
														),
														INNER, ALL
														),athleteid,date,starttime,period);



// OUTPUT(gpsdata1);
// OUTPUT(gpsaverages);
OUTPUT(gpsaverages,,'~Athlete360::OUT::charts::WBBgpsgameathletes',OVERWRITE);