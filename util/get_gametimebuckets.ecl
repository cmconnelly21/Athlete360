IMPORT STD;
Export get_gametimebuckets(Unsigned3 starttime, Unsigned3 endtime):= FUNCTION

// startTime := std.date.FromStringToTime(sTime, '%H:%M:%S');    //if the field is already having Time converted, we can skip this convertion here
// endTime := std.date.FromStringToTime(eTime, '%H:%M:%S');     //if the field is already having Time converted, we can skip this convertion here
mDiff :=  std.date.Minute(endTime) - std.date.Minute(startTime);
hDiff :=  std.date.Hour(endTime) - std.date.Hour(startTime);

Return (Integer)(((Integer)((Integer)(((hdiff * 60) + mdiff) / 15))) +1);

END;