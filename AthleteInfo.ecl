EXPORT AthleteInfo := MODULE
	EXPORT Layout := RECORD
		STRING20 Name;
		STRING5 Team;
		STRING3 Position;
		STRING4 Year;
	END;

	EXPORT File := DATASET('~athlete360::in::AthleteInfo.csv',Layout,CSV(HEADING(1)));
END;