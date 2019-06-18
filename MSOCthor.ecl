IMPORT $;
IMPORT STD;

EXPORT MSOCthor := MODULE
	EXPORT Layout := RECORD
		STRING Date;
		STRING Time;
		STRING Lastname;
		STRING Firstname;
		STRING Score;
		STRING Fatigue;
		STRING Mood;
		STRING Soreness;
		STRING Stress;
		STRING Sleepquality;
		STRING Sleephours;
		STRING Rating;
		STRING Duration;
		STRING Trainingload;
		STRING Category;
		STRING Team;
	END;

	EXPORT thorlayout := RECORD
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		STRING Name;
		DECIMAL5_2 Score;
		UNSIGNED1 Fatigue;
		UNSIGNED1 Mood;
		UNSIGNED1 Soreness;
		UNSIGNED1 Stress;
		UNSIGNED1 Sleepquality;
		UNSIGNED1 Sleephours;
		DECIMAL5_2 Rating;
		UNSIGNED1 Duration;
		UNSIGNED1 Trainingload;
		STRING Category;
		STRING Team;
	END;
	
	EXPORT File := DATASET('~Athlete360::OUT::MSOClr',Layout,CSV(HEADING(1)));
	EXPORT thorfile := PROJECT(file,TRANSFORM(thorlayout,
                  SELF.Date := STD.date.FromStringToDate(LEFT.Date,'%Y-%m-%d');
									SELF.Time := IF(std.str.splitwords(Left.Time, ' ')[2]='PM',
									1200 + STD.date.FromStringToTime(Left.Time,'%H:%M'),
									STD.date.FromStringToTime(Left.Time,'%H:%M'));
                  self.Name := left.Firstname + ' ' + left.Lastname;
									self.Score := (DECIMAL5_2)left.Score;
									self.Fatigue := (Unsigned1)left.Fatigue;
									self.Mood := (Unsigned1)left.Mood;
									self.Soreness := (Unsigned1)left.Soreness;
									self.Stress := (Unsigned1)left.Stress;
									self.SleepQuality := (Unsigned1)left.SleepQuality;
									self.SleepHours := (unsigned1)left.SleepHours;
									self.Rating := (DECIMAL5_2)left.Rating;
									self.Duration := (Unsigned1)left.Duration;
                  self.TrainingLoad := (Unsigned1)left.TrainingLoad;
                  self.Category := left.Category;
                  self.Team := left.Team));
END;
