import athlete360;

datafile := Athlete360.files_stg.MSOCgpsNUM_stgfile;

dedupdata := dedup(sort(datafile, date),date);

temp1 := RECORD
Unsigned4 date;
END;


datelist := Project(dedupdata,transform({RECORDOF(temp1)}, self:= left));

OUTPUT(datelist);