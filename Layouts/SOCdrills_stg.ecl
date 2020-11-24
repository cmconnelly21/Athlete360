EXPORT SOCdrills_stg  := RECORD
	STRING20 drillname;
	Unsigned3 drillnum;
	string19 wuid := workunit;
END;