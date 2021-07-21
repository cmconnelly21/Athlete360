EXPORT WBBdatefile  := RECORD
	STRING20 date;
	STRING20 gamedaycount;
	UNSIGNED4 week;
	string19 wuid := workunit;
END;