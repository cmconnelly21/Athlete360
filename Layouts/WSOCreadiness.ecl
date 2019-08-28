EXPORT WSOCReadiness := RECORD
		STRING25 Timestamp;
		STRING20 Name;
		INTEGER1 Fatigue;
		INTEGER1 MuscleSoreness;
		INTEGER1 SleepQuality;
		INTEGER1 Stress;
		INTEGER1 Hydration;
		STRING3 Pain;
		STRING25 Explanation;
		string19 wuid := workunit;
	END;