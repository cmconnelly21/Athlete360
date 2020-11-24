import Athlete360;

// please add all the build_stg modules inside the sequential like how I added for two

export stg_build := sequential(
    Athlete360.build_stg.build_Athleteinfofile,
    Athlete360.build_stg.build_WSOCjump,
    Athlete360.build_stg.build_WSOCnordbord,
		Athlete360.build_stg.build_MSOCnordbord,
		Athlete360.build_stg.build_MSOCgps,
		Athlete360.build_stg.build_MSOCgpsNUM,
		Athlete360.build_stg.build_MSOCgymaware,
		Athlete360.build_stg.build_WSOCgymaware,
		Athlete360.build_stg.build_MSOCjump,
		Athlete360.build_stg.build_WSOCreadiness,
		Athlete360.build_stg.build_WSOCtrainingload,
		Athlete360.build_stg.build_MSOCreadiness,
		Athlete360.build_stg.build_MSOCreadinessNUM,
		Athlete360.build_stg.build_MSOCtrainingload,
		Athlete360.build_stg.build_MSOCtrainingloadNUM,
		Athlete360.build_stg.build_WSOCdatefile,
		Athlete360.build_stg.build_WSOCtesting,
		Athlete360.build_stg.build_MSOCtesting,
		Athlete360.build_stg.build_MSOCrawgps,
		Athlete360.build_stg.build_WSOCgps,
		Athlete360.build_stg.build_WSOCrawgps,
		Athlete360.build_stg.build_SOCdrills
		
);