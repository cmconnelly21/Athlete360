	EXPORT WSOCtesting_stg := RECORD
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
		string19 wuid := workunit;
    UNSIGNED3 athleteid := 0;
	END;