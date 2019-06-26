EXPORT WSOClr := MODULE
	EXPORT Layout := RECORD
		STRING25 _date;
		STRING30 Timestamp;
		STRING30 Name;
		INTEGER1 Fatigue;
		INTEGER1 MuscleSoreness;
		INTEGER1 SleepQuality;
		INTEGER1 Stress;
		INTEGER1 Hydration;
		STRING5 Pain;
		STRING50 Explanation;
		INTEGER1 WellnessSum;
		STRING30 SessionType;
		INTEGER1 SessionDuration;
		INTEGER1 Breathlessness;
		INTEGER1 LowerBodyLoad;
		INTEGER1 UpperBodyLoad;
		INTEGER1 SessionOverall;
	END;
	EXPORT File := DATASET('~Athlete360::OUT::WSOClr',Layout,CSV(HEADING(1)));
END;