EXPORT WSOCReadiness := MODULE
	EXPORT Layout := RECORD
		STRING20 Date;
		STRING25 Timestamp;
		STRING20 Name;
		INTEGER1 Fatigue;
		INTEGER1 MuscleSoreness;
		INTEGER1 SleepQuality;
		INTEGER1 Stress;
		INTEGER1 Hydration;
		STRING3 Pain;
		STRING25 Explanation;
		INTEGER1 Welnesssum;
	END;

	EXPORT File:= DATASET('~athlete360::in::WSOC_Readiness_Monitoring.csv',Layout,CSV(HEADING(1)));
END;