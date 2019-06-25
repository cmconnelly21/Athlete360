EXPORT AthleteInfo := MODULE
	EXPORT Layout := RECORD
		STRING20 Name;
		STRING5 Team;
		STRING3 Position;
		STRING4 Year;
		STRING athleteID;
	END;

	EXPORT File := DATASET('~athlete360::in::Athlete360_AthleteInfo.csv',Layout,CSV(HEADING(1)));
END;