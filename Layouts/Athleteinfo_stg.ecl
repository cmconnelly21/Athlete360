EXPORT AthleteInfo_stg := RECORD
		STRING20 Name;
		STRING5 Team;
		STRING3 Position;
		UNSIGNED3 Year;
		UNSIGNED3 athleteID;
		String wuid := workunit;
	END;