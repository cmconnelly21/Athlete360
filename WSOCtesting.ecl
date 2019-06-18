IMPORT $;
IMPORT STD;

EXPORT WSOCtesting := MODULE
	EXPORT Layout := RECORD
		STRING Name;
		STRING Test;
		STRING Date;
		STRING IsitSpeed;
		STRING Trial1;
		STRING Trial2;
		STRING Trial3;
		STRING Trial4;
		STRING Trial5;
		STRING Trial6;
		STRING Average;
		STRING Bestscore;
	END;
	EXPORT Layout1 := RECORD
		STRING Name;
		STRING Test;
		UNSIGNED4 Date;
		STRING IsitSpeed;
		DECIMAL5_2 Trial1;
		DECIMAL5_2 Trial2;
		DECIMAL5_2 Trial3;
		DECIMAL5_2 Trial4;
		DECIMAL5_2 Trial5;
		DECIMAL5_2 Trial6;
		DECIMAL5_2 Average;
		DECIMAL5_2 Bestscore; 	
	END;

	EXPORT File := DATASET('~athlete360::in::wsoctesting.csv',Layout,CSV(HEADING(1)));
	EXPORT processedfile := PROJECT(File,TRANSFORM(Layout1,SELF.date := STD.date.fromstringtodate(LEFT.date,'%Y/%m/%d');
																								SELF.Name := LEFT.Name;
																								SELF.Test := LEFT.Test;
																								SELF.IsitSpeed := LEFT.IsitSpeed;
																								SELF.Trial1 := (DECIMAL5_2)LEFT.Trial1;
																								SELF.Trial2 := (DECIMAL5_2)LEFT.Trial2;
																								SELF.Trial3 := (DECIMAL5_2)LEFT.Trial3;
																								SELF.Trial4 := (DECIMAL5_2)LEFT.Trial4;
																								SELF.Trial5 := (DECIMAL5_2)LEFT.Trial5;
																								SELF.Trial6 := (DECIMAL5_2)LEFT.Trial6;
																								SELF.Average := (DECIMAL5_2)LEFT.Average;
																								SELF.Bestscore := (DECIMAL5_2)LEFT.Bestscore));
END;