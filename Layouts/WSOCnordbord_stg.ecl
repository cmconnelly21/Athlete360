﻿	EXPORT WSOCnordbord_stg := RECORD
		STRING Name;
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		STRING Test;
		UNSIGNED1 Reps_L;
		UNSIGNED1 Reps_R;
		DECIMAL5_2 MAX_FORCE_L;
		DECIMAL5_2 MAX_FORCE_R;
		DECIMAL5_2 MAX_IMBALANCE;
		DECIMAL5_2 MAX_TORQUE_L;
		DECIMAL5_2 MAX_TORQUE_R;
		DECIMAL5_2 AVG_FORCE_L;
		DECIMAL5_2 AVG_FORCE_R;
		DECIMAL5_2 AVG_IMBALANCE;
		DECIMAL5_2 AVG_TORQUE_L;
		DECIMAL5_2 AVG_TORQUE_R;
		string19 wuid := workunit;
    UNSIGNED3 athleteid := 0;
	END;