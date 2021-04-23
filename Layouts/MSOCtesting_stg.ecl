	EXPORT MSOCtesting_stg := RECORD
		STRING Name;
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		STRING Test;
		STRING IsitSpeed;
		DECIMAL5_2 Trial1;
		DECIMAL5_2 Trial2;
		DECIMAL5_2 daybest;
		string19 wuid := workunit;
    UNSIGNED3 athleteid := 0;
	END;