EXPORT WSOCtrainingload := RECORD
		STRING15 Timestamp;
		STRING20 Name;
		STRING20 SessionType;
		INTEGER1 SessionDuration;
		INTEGER1 Breathlessness;
		INTEGER1 LowerBodyLoad;
		INTEGER1 UpperBodyLoad;
		INTEGER1 SessionOverall;
		STRING10 Date;
		string19 wuid := workunit;
	END;