EXPORT MSOCJump_stg := RECORD
    string30 name;
    string30 test;
    UNSIGNED4 date;
    UNSIGNED4 time;
    string10 bodyweight;
	string30 trialname;
    decimal10_5 trial1;
    decimal10_5 trial2;
    decimal10_5 trial3;
		decimal10_5 trial4;
		decimal10_5 trial5;
		string19 wuid := workunit;
		UNSIGNED3 athleteid := 0;
	END;