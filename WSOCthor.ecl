IMPORT $;
IMPORT STD;

csvData := $.WSOClr.File;

wsocthorlayout := RECORD
		UNSIGNED4 _date;
		UNSIGNED3 _time;
		STRING30 Name;
		UNSIGNED1 Fatigue;
		UNSIGNED1 MuscleSoreness;
		UNSIGNED1 SleepQuality;
		UNSIGNED1 Stress;
		UNSIGNED1 Hydration;
		STRING5 Pain;
		STRING25 Explanation;
		UNSIGNED1 WellnessSum;
		STRING30 SessionType;
		UNSIGNED1 SessionDuration;
		UNSIGNED1 Breathlessness;
		UNSIGNED1 LowerBodyLoad;
		UNSIGNED1 UpperBodyLoad;
		UNSIGNED1 SessionOverall;	
END;

thordata := PROJECT(csvData,TRANSFORM(wsocthorlayout,
                  SELF._date := STD.date.FromStringToDate(LEFT.Timestamp,'%m/%d/%Y');
									SELF._time := STD.date.FromStringToTime(LEFT.Timestamp,'%H:%M:%S');
                  self.Name := left.Name;
									self.Fatigue := (Unsigned1)left.Fatigue;
									self.MuscleSoreness := (Unsigned1)left.MuscleSoreness;
									self.SleepQuality := (Unsigned1)left.SleepQuality;
									self.Stress := (Unsigned1)left.Stress;
									self.Hydration := (Unsigned1)left.Hydration;
									SELF.Pain := LEFT.Pain;
									SELF.Explanation := LEFT.Explanation;
									self.WellnessSum := (Unsigned1)left.WellnessSum;
									self.SessionType := left.SessionType;
									self.SessionDuration := (Unsigned1)left.SessionDuration;
                  self.Breathlessness := (Unsigned1)left.Breathlessness;
                  self.LowerBodyLoad := (Unsigned1)left.LowerBodyLoad;
                  self.UpperBodyLoad := (Unsigned1)left.UpperBodyLoad;
                  self.SessionOverall := (Unsigned1)left.SessionOverall));


EXPORT WSOCthor := OUTPUT(thordata);									