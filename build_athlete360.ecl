IMPORT Athlete360;

#STORED('filedate','20190702');

EXPORT build_athlete360 := 

sequential(Athlete360.spray_build, Athlete360.stg_build);


