EXPORT WSOCtrainingload_stg := RECORD
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		STRING20 Name;
		STRING30 SessionType;
		UNSIGNED1 SessionDuration;
		UNSIGNED1 Breathlessness;
		UNSIGNED1 LowerBodyLoad;
		UNSIGNED1 UpperBodyLoad;
		UNSIGNED1 SessionOverall;
		string19 wuid := workunit;
		UNSIGNED3 athleteid := 0;
	END;