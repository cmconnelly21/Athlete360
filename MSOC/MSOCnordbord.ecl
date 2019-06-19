IMPORT $;
IMPORT STD;

EXPORT MSOCnordbord := MODULE
	EXPORT Layout := RECORD
		STRING Name;
		STRING Date;
		STRING Time;
		STRING Test;
		STRING Reps_L;
		STRING Reps_R;
		STRING MAX_FORCE_L;
		STRING MAX_FORCE_R;
		STRING MAX_IMBALANCE;
		STRING MAX_TORQUE_L;
		STRING MAX_TORQUE_R;
		STRING AVG_FORCE_L;
		STRING AVG_FORCE_R;
		STRING AVG_IMBALANCE;
		STRING AVG_TORQUE_L;
		STRING AVG_TORQUE_R;
	END;
	EXPORT Layout1 := RECORD
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
	END;

	EXPORT File := DATASET('~athlete360::in::msocnordbord.csv',Layout,CSV(HEADING(3)));
	EXPORT processedfile := PROJECT(File,TRANSFORM(Layout1,SELF.date := STD.date.fromstringtodate(LEFT.date,'%Y/%m/%d');
																								SELF.time := STD.date.fromstringtotime (LEFT.time, '%H:%M');
																								SELF.Name := LEFT.Name;
																								SELF.Test := LEFT.Test;
																								SELF.REPS_L := (UNSIGNED1)LEFT.REPS_L;
																								SELF.REPS_R := (UNSIGNED1)LEFT.REPS_R;
																								SELF.MAX_FORCE_L := (DECIMAL5_2)LEFT.MAX_FORCE_L;
																								SELF.MAX_FORCE_R := (DECIMAL5_2)LEFT.MAX_FORCE_L;
																								SELF.MAX_IMBALANCE := (DECIMAL5_2)LEFT.MAX_IMBALANCE;
																								SELF.MAX_TORQUE_L := (DECIMAL5_2)LEFT.MAX_TORQUE_L;
																								SELF.MAX_TORQUE_R := (DECIMAL5_2)LEFT.MAX_TORQUE_R;
																								SELF.AVG_FORCE_L := (DECIMAL5_2)LEFT.AVG_FORCE_L;
																								SELF.AVG_FORCE_R := (DECIMAL5_2)LEFT.AVG_FORCE_R;
																								SELF.AVG_IMBALANCE := (DECIMAL5_2)LEFT.AVG_IMBALANCE;
																								SELF.AVG_TORQUE_L := (DECIMAL5_2)LEFT.AVG_TORQUE_L;
																								SELF.AVG_TORQUE_R := (DECIMAL5_2)LEFT.AVG_TORQUE_R));
END;