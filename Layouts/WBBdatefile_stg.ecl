EXPORT WBBdatefile_stg  := RECORD
	UNSIGNED4 date;
	STRING20 gamedaycount;
	UNSIGNED4 week;
	Unsigned3 Daynum;
	string19 wuid := workunit;
END;