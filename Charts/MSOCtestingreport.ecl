IMPORT Athlete360, STD;

testingdata := athlete360.files_stg.MSOCtesting_stgfile;

trials := [testingdata.trial1, testingdata.trial2, testingdata.trial3, testingdata.trial4, testingdata.trial4, testingdata.trial5, testingdata.trial6];

DATA_AVE_ID := SORT(
	TABLE(testingdata, 
		{name,test,
		decimal5_2 avg_trial1 := AVE(group, trials);
		decimal5_2 avg_trial2 := AVE(group,trial2);
		decimal5_2 avg_trial3 := AVE(group,trial3);
		decimal5_2 avg_trial4 := AVE(group,trial4);
		decimal5_2 avg_trial5 := AVE(group,trial5);
		decimal5_2 avg_trial6 := AVE(group,trial6);
		decimal5_2 best_trial1 := IF(isitspeed = 'yes', MIN(group, trial1), MAX(group, trial1));
		decimal5_2 best_trial2 := IF(isitspeed = 'yes', MIN(group, trial2), MAX(group, trial2));
		decimal5_2 best_trial3 := IF(isitspeed = 'yes', MIN(group, trial3), MAX(group, trial3));
		decimal5_2 best_trial4 := IF(isitspeed = 'yes', MIN(group, trial4), MAX(group, trial4));
		decimal5_2 best_trial5 := IF(isitspeed = 'yes', MIN(group, trial5), MAX(group, trial5));
		decimal5_2 best_trial6 := IF(isitspeed = 'yes', MIN(group, trial6), MAX(group, trial6));
		},
		name, test,
		MERGE
		), name, test
);


new_layout := RECORD
		UNSIGNED4 Name;
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		UNSIGNED4 Test;
		UNSIGNED1 IsitSpeed;
		DECIMAL5_2 Trial1;
		DECIMAL5_2 Trial2;
		DECIMAL5_2 Trial3;
		DECIMAL5_2 Trial4;
		DECIMAL5_2 Trial5;
		DECIMAL5_2 Trial6;
		DECIMAL5_2 avg_Trial1;
		DECIMAL5_2 avg_Trial2;
		DECIMAL5_2 avg_Trial3;
		DECIMAL5_2 avg_Trial4;
		DECIMAL5_2 avg_Trial5;
		DECIMAL5_2 avg_Trial6;
		DECIMAL5_2 avg;
		DECIMAL5_2 best;
END;


// Finaldata := join(testingdata, DATA_AVE_ID,
									// Left.name = Right.name,
									// Transform(New_layout,
															// self.avg_trial1 := right.avg_trial1,
															// Self := LEFT;
															// )
															// );




OUTPUT(DATA_AVE_ID);
// OUTPUT(finaldata);