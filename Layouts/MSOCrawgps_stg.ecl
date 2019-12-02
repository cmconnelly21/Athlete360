	EXPORT MSOCrawgps_stg := RECORD
		UNSIGNED3 PlayerID;
		STRING Name;
		UNSIGNED4 Date;
		STRING12 Time;
		DECIMAL10_5 ElapsedTime;
		DECIMAL10_5 Latitude;
		DECIMAL10_5 Longitude;
		DECIMAL10_5 Speed;
		DECIMAL10_5 Accelimpulse;
		UNSIGNED3 HeartRate;
		string19 wuid := workunit;
    UNSIGNED3 athleteid := 0;
	END;