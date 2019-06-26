IMPORT $;
IMPORT STD;

EXPORT WSOCdatefile := MODULE
EXPORT Layout := RECORD
	STRING date;
	STRING gamedaycount;
END;

EXPORT Layout1 := RECORD
	UNSIGNED4 date;
	STRING gamedaycount;
END;

EXPORT File := DATASET('~athlete360::in::WSOC_dates.csv',Layout,CSV(HEADING(1)));
EXPORT processedfile := PROJECT(File,TRANSFORM(Layout1,SELF.date := STD.date.fromstringtodate(LEFT.date,'%Y/%m/%d');
																								SELF.gamedaycount := LEFT.gamedaycount));
END;
