EXPORT MSOCreadiness := MODULE
	EXPORT Layout := RECORD
		STRING Date;
		STRING Time;
		STRING Lastname;
		STRING Firstname;
		STRING Score;
		STRING Fatigue;
		STRING Mood;
		STRING Soreness;
		STRING Stress;
		STRING Sleepquality;
		STRING Sleephours;
	END;
	EXPORT File := DATASET('~athlete360::in::msocreadiness.csv',Layout,CSV(HEADING(3)));
END;