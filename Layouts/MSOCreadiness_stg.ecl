	EXPORT MSOCreadiness_stg := RECORD
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		STRING Name;
		DECIMAL5_2 Score;
		UNSIGNED1 Fatigue;
		UNSIGNED1 Mood;
		UNSIGNED1 Soreness;
		UNSIGNED1 Stress;
		UNSIGNED1 Sleepquality;
		UNSIGNED1 Sleephours;
		string19 wuid := workunit;
		UNSIGNED3 athleteid := 0;
	END;