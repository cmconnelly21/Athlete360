IMPORT Athlete360, STD;

subdata := Athlete360.files_stg.MSOCreadinessNUM_stgfile;

temp1 := RECORD
UNSIGNED3 athleteid;
UNSIGNED4 Date;
UNSIGNED3 DayNum;
UNSIGNED3 Time;
DECIMAL5_2 Score;
UNSIGNED1 Fatigue;
UNSIGNED1 Mood;
UNSIGNED1 Soreness;
UNSIGNED1 Stress;
UNSIGNED1 Sleepquality;
UNSIGNED1 Sleephours;
END;

subdata1 := PROJECT(subdata,TRANSFORM({RECORDOF(temp1)}, self := left));

DATA_AVE_ID := SORT(
	TABLE(subdata1,
				{athleteid,
				DECIMAL5_2 avg_score := AVE(group,Score);
				DECIMAL5_2 SD_score := SQRT(VARIANCE(group,Score));
				},
				athleteid,
				MERGE
				), athleteid
	);
	
New_layout := RECORD
UNSIGNED3 athleteid;
UNSIGNED4 Date;
UNSIGNED3 DayNum;
UNSIGNED3 Time;
DECIMAL5_2 z_score;
UNSIGNED1 Fatigue;
UNSIGNED1 Mood;
UNSIGNED1 Soreness;
UNSIGNED1 Stress;
UNSIGNED1 Sleepquality;
UNSIGNED1 Sleephours;
END;



EXPORT MSOC_sub_avgs := join(subdata1, DATA_AVE_ID,
										Left.athleteid = Right.athleteid,
										Transform(New_layout,
										Self.z_score := (left.Score-right.avg_score)/right.SD_score,
										Self := Left
										),
										INNER, ALL
										);
