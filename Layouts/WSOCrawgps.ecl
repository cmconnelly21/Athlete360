	EXPORT WSOCrawgps := RECORD
		STRING PlayerID;
		STRING Name;
		STRING Time;
		STRING ElapsedTime;
		STRING Latitude;
		STRING Longitude;
		STRING Speed;
		STRING Accelimpulse;
		STRING HeartRate;
		string19 wuid := workunit;
		STRING filename {VIRTUAL( logicalfilename )};
	END;