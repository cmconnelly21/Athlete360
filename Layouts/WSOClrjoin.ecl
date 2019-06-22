IMPORT $;

srtWSOCRead := SORT($.WSOCreadiness.File,Date,Name);
dedup_WSOCRead := DEDUP(srtWSOCRead,LEFT.Date=RIGHT.Date AND LEFT.Name=RIGHT.Name)
																							:PERSIST('~Athlete360::PERSIST::dedup_WSOCRead');

WSOClr := JOIN(dedup_WSOCRead,$.WSOCload.File,LEFT.Name=RIGHT.Name AND
																													LEFT.Date=RIGHT.Date,
																													LEFT OUTER, LOOKUP);
OUTPUT(WSOClr,,'~Athlete360::OUT::WSOClr',CSV,OVERWRITE);