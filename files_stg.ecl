EXPORT files_stg := MODULE

IMPORT Athlete360;

    EXPORT WSOCdate_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_dates', Athlete360.Layouts.WSOCdatefile_stg, THOR, OPT);
		EXPORT MSOCdate_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_dates', Athlete360.Layouts.MSOCdatefile_stg, THOR, OPT);
		EXPORT MSOCtesting_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_testing', Athlete360.Layouts.MSOCtesting_stg, THOR, OPT);
		EXPORT MSOCgps_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_gps', Athlete360.Layouts.MSOCgps_stg, THOR, OPT);
		EXPORT MSOCgpsNUM_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_gpsNUM', Athlete360.Layouts.MSOCgpsNUM_stg, THOR, OPT);
		EXPORT MSOCrawgps_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_rawgps', Athlete360.Layouts.MSOCrawgps_stg, THOR, OPT);
		EXPORT WSOCgps_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_gps', Athlete360.Layouts.WSOCgps_stg, THOR, OPT);
		EXPORT WSOCrawgps_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_rawgps', Athlete360.Layouts.WSOCrawgps_stg, THOR, OPT);
		EXPORT MSOCgymaware_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_gymaware', Athlete360.Layouts.MSOCgymaware_stg, THOR, OPT);
		EXPORT MSOCjump_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_jump', Athlete360.Layouts.MSOCjump_stg, THOR, OPT);
		EXPORT MSOCnordbord_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_nordbord', Athlete360.Layouts.MSOCnordbord_stg, THOR, OPT);
		EXPORT MSOCreadiness_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_readiness', Athlete360.Layouts.MSOCreadiness_stg, THOR, OPT);
		EXPORT MSOCreadinessNUM_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_readinessNUM', Athlete360.Layouts.MSOCreadinessNUM_stg, THOR, OPT);
		EXPORT MSOCtrainingloadNUM_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_trainingloadNUM', Athlete360.Layouts.MSOCtrainingloadNUM_stg, THOR, OPT);
		EXPORT MSOCtrainingload_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_trainingload', Athlete360.Layouts.MSOCtrainingload_stg, THOR, OPT);
		EXPORT WSOCjump_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_jump', Athlete360.Layouts.WSOCjump_stg, THOR, OPT);
		EXPORT WSOCnordbord_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_nordbord', Athlete360.Layouts.WSOCnordbord_stg, THOR, OPT);
		EXPORT WSOCreadiness_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_readiness', Athlete360.Layouts.WSOCreadiness_stg, THOR, OPT);
		EXPORT WSOCtesting_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_testing', Athlete360.Layouts.WSOCtesting_stg, THOR, OPT);
		EXPORT WSOCtrainingload_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_trainingload', Athlete360.Layouts.WSOCtrainingload_stg, THOR, OPT);
		EXPORT WSOCgymaware_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_gymaware', Athlete360.Layouts.WSOCgymaware_stg, THOR, OPT);
		EXPORT Athleteinfo_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'athleteinfo', Athlete360.Layouts.Athleteinfo_stg, THOR, OPT);
END;
