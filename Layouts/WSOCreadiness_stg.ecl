EXPORT WSOCReadiness_stg := RECORD
		UNSIGNED4 date;
		UNSIGNED3 time;
		STRING30 Name;
		UNSIGNED1 Fatigue;
		UNSIGNED1 MuscleSoreness;
		UNSIGNED1 SleepQuality;
		UNSIGNED1 Stress;
		UNSIGNED1 Hydration;
		STRING5 Pain;
		STRING25 Explanation;
		UNSIGNED1 WellnessSum;
		string19 wuid := workunit;
		string20 athleteid := '';
	END;