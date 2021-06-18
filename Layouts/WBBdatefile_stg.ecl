EXPORT WBBdatefile_stg  := RECORD
	UNSIGNED4 date;
	STRING20 gamedaycount;
	Unsigned3 Daynum;
	string19 wuid := workunit;
END;