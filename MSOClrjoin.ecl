IMPORT $;

srtMSOCRead := SORT($.MSOCreadiness.File,Date,Lastname,Firstname);

MSOClr := JOIN(srtMSOCRead,$.MSOCtrainingloads.File,LEFT.Date=RIGHT.Date AND
																													LEFT.Lastname = LEFT.Lastname AND 
																													LEFT.Firstname = LEFT.Firstname,
																													LEFT OUTER, LOOKUP);
OUTPUT(MSOClr,,'~Athlete360::OUT::MSOClr',CSV,OVERWRITE);