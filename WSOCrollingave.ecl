IMPORT $;

WSOclrdata_splitCnt := PROJECT($.WSOClr.File,TRANSFORM({RECORDOF(LEFT); INTEGER splitCnt}, 
																SELF.splitCnt := (COUNTER / 5) + IF(COUNTER % 5 > 0 , 1, 0);
																SELF := LEFT));
// the above just adds the same number for every 5 consecutive records, and the next 5 are set with next number incrementally

tableRec := RECORD
	//$.WSOClr.File;
	STRING20 Name := WSOClrdata_splitCnt.Name;
	DECIMAL5_2 SessionOverall_roll := AVE(GROUP, WSOClrdata_splitCnt.SessionOverall);
	DECIMAL5_2 WellnessSum_roll := AVE(GROUP, WSOClrdata_splitCnt.WellnessSum);
END;

OUTPUT(TABLE($.WSOClr.File, tableRec, Name,splitCnt));

// this Table action is grouping by splitcnt, so every consecutive 5 records are grouped and applied for AVE actions
