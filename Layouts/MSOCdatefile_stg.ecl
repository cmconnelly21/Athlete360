EXPORT MSOCdatefile_stg  := RECORD
	UNSIGNED4 date;
	STRING5 gamedaycount;
	string19 wuid := workunit;
END;