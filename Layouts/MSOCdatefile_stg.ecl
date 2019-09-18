EXPORT MSOCdatefile_stg  := RECORD
	UNSIGNED4 date;
	STRING20 gamedaycount;
	string19 wuid := workunit;
END;