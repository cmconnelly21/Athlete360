IMPORT Athlete360, std;

rawDs := SORT(Athlete360.RawGPS.processedfile, name, ElapsedTime) : INDEPENDENT;

completegpsdata := join(dedup(sort(rawDs, name), name),

Athlete360.files_stg.MSOCgps_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.name := RIGHT.name; 
														SELF.drillname := RIGHT.drillname;
														SELF.drillstarttime := RIGHT.drillstarttime;
														SELF.Date := RIGHT.Date;
														SELF := LEFT;), 

left outer

);

OUTPUT(completegpsdata);