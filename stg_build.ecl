import Athlete360;

// please add all the build_stg modules inside the sequential like how I added for two

export stg_build := sequential(Athlete360.build_stg.build_WSOCjump,
Athlete360.build_stg.build_WSOCnordbord);