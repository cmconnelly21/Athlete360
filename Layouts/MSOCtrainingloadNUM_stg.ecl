EXPORT MSOCtrainingloadNUM_stg := RECORD
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		UNSIGNED4 Name;
		DECIMAL5_2 Rating;
		UNSIGNED1 Duration;
		UNSIGNED1 Trainingload;
		UNSIGNED1 Category;
		UNSIGNED1 Team;
		string19 wuid := workunit;
		unsigned3 athleteid := 0;
	END;