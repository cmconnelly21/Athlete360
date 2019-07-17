IMPORT $;
IMPORT STD;

EXPORT RawGPS := MODULE
	EXPORT Layout := RECORD
		STRING PlayerID;
		STRING Name;
		STRING Time;
		STRING ElapsedTime;
		STRING Latitude;
		STRING Longitude;
		STRING Speed;
		STRING Accelimpulse;
		STRING HeartRate;
	END;
	EXPORT Layout1 := RECORD
		UNSIGNED3 PlayerID;
		STRING Name;
		UNSIGNED4 Time;
		DECIMAL10_5 ElapsedTime;
		DECIMAL10_5 Latitude;
		DECIMAL10_5 Longitude;
		DECIMAL10_5 Speed;
		DECIMAL10_5 Accelimpulse;
		UNSIGNED3 HeartRate; 	
	END;

	EXPORT File := DATASET('~athlete360::in::ms_rawgps06122019.csv',Layout,CSV(HEADING(1)));
	EXPORT processedfile := PROJECT(File,TRANSFORM(Layout1,
																								SELF.time := (UNSIGNED4)LEFT.Time;
																								SELF.Name := LEFT.Name;
																								SELF.PlayerID := (UNSIGNED3)LEFT.PlayerID;
																								SELF.HeartRate := (UNSIGNED3)LEFT.HeartRate;
																								SELF.ElapsedTime := (DECIMAL10_5)LEFT.ElapsedTime;
																								SELF.Latitude := (DECIMAL10_5)LEFT.Latitude;
																								SELF.Longitude := (DECIMAL10_5)LEFT.Longitude;
																								SELF.Speed := (DECIMAL10_5)LEFT.Speed;
																								SELF.Accelimpulse := (DECIMAL10_5)LEFT.Accelimpulse));
END;