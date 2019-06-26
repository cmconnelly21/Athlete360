EXPORT MSOCtrainingload := MODULE
	EXPORT Layout := RECORD
		STRING Date;
		STRING Time;
		STRING Lastname;
		STRING Firstname;
		STRING Rating;
		STRING Duration;
		STRING Trainingload;
		STRING Category;
		STRING Team;
	END;
	EXPORT File := DATASET('~athlete360::in::msoctrainingloads.csv',Layout,CSV(HEADING(3)));
END;