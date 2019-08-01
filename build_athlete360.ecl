IMPORT Athlete360;



EXPORT build_athlete360 := 

sequential(Athlete360.spray_build, Athlete360.stg_build, athlete360.charts_build, Athlete360.despray_build);


