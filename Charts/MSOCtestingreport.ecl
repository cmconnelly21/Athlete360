IMPORT Athlete360, STD;

testingdata := athlete360.files_stg.MSOCtesting_stgfile;

DATA_AVE_ID := SORT(
	TABLE(testingdata, 
		{name,test,
		decimal5_2 avg_score := AVE(group, daybest);
		decimal5_2 high_score := MAX(group, daybest);
		decimal5_2 low_score := MIN(group, daybest);
		},
		name, test,
		MERGE
		), name, test
);



new_layout := RECORD
		STRING Name;
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		STRING Test;
		STRING IsitSpeed;
		DECIMAL5_2 Trial1;
		DECIMAL5_2 Trial2;
		DECIMAL5_2 daybest;
		DECIMAL5_2 avg_score;
		DECIMAL5_2 high_score;
		DECIMAL5_2 low_score;
		DECIMAL5_2 best_score;
END;


Finaldata := join(testingdata, DATA_AVE_ID,
									Left.name = Right.name AND
									left.test = right.test,
									Transform(New_layout,
															self.date := left.date;
															self.best_score := IF(left.isitspeed = 'Yes', right.low_score, right.high_score);
															self.avg_score := right.avg_score;
															self.high_score := right.high_score;
															self.low_score := right.low_score;
															Self := LEFT;
															)
															);




OUTPUT(DATA_AVE_ID);
OUTPUT(finaldata, all);