EXPORT WSOCload := MODULE
	EXPORT Layout := RECORD
		STRING15 Timestamp;
		STRING20 Name;
		STRING20 SessionType;
		INTEGER1 SessionDuration;
		INTEGER1 Breathlessness;
		INTEGER1 LowerBodyLoad;
		INTEGER1 UpperBodyLoad;
		INTEGER1 SessionOverall;
		STRING10 Date;	
	END;

	EXPORT File := DATASET('~athlete360::in::wsoc_load_monitoring.csv',Layout,CSV(HEADING(1)));
END;