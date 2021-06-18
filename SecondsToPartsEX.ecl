IMPORT STD;

// 1622810533 is 20210604 at 8:42:13 EST, 12:42:13 GMT

fulltime := std.date.secondstoparts(1622810533);


realtime := std.date.timezone.tolocaltime(fulltime.time,'EDT');

OUTPUT(fulltime);
OUTPUT(realtime);