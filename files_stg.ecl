EXPORT files_stg := MODULE

IMPORT Athlete360;

        EXPORT WSOCdate_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_dates', Athlete360.Layouts.WSOCdatefile, THOR, OPT);
		EXPORT MSOCtesting_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_testing', Athlete360.Layouts.MSOCtesting, THOR, OPT);
		EXPORT MSOCgps_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_gps', Athlete360.Layouts.MSOCgps, THOR, OPT);
		EXPORT MSOCgymaware_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_gymaware', Athlete360.Layouts.MSOCgymaware, THOR, OPT);
		EXPORT MSOCjump_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_jump', Athlete360.Layouts.MSOCjump, THOR, OPT);
		EXPORT MSOCnordbord_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_nordbord', Athlete360.Layouts.MSOCnordbord, THOR, OPT);
		EXPORT MSOCreadiness_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_readiness', Athlete360.Layouts.MSOCreadiness, THOR, OPT);
		EXPORT MSOCtrainingload_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ms_trainingload', Athlete360.Layouts.MSOCtrainingload, THOR, OPT);
		EXPORT WSOCjump_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_jump', Athlete360.Layouts.WSOCjump_stg, THOR, OPT);
		EXPORT WSOCnordbord_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_nordbord', Athlete360.Layouts.WSOCnordbord, THOR, OPT);
		EXPORT WSOCreadiness_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_readiness', Athlete360.Layouts.WSOCreadiness, THOR, OPT);
		EXPORT WSOCtesting_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_testing', Athlete360.Layouts.WSOCtesting, THOR, OPT);
		EXPORT WSOCtrainingload_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_trainingload', Athlete360.Layouts.WSOCtrainingload, THOR, OPT);
		EXPORT WSOCgymaware_stgfile := DATASET( Athlete360.util.constants.stg_prefix + 'ws_gymaware', Athlete360.Layouts.WSOCgymaware, THOR, OPT);		
END;
