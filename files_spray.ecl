﻿EXPORT files_spray := MODULE

IMPORT Athlete360;

    EXPORT WSOCdatefile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_dates', Athlete360.Layouts.WSOCdatefile, CSV(HEADING(1)), OPT);
		EXPORT MSOCtestingfile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_testing', Athlete360.Layouts.MSOCtesting, CSV(HEADING(1)), OPT);
		EXPORT MSOCgpsfile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_gps', Athlete360.Layouts.MSOCgps, CSV(HEADING(1)), OPT);
		EXPORT MSOCgymawarefile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_gymaware', Athlete360.Layouts.MSOCgymaware, CSV(HEADING(1)), OPT);
		EXPORT MSOCjumpfile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_jump', Athlete360.Layouts.MSOCjump, CSV(HEADING(1)), OPT);
		EXPORT MSOCnordbordfile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_nordbord', Athlete360.Layouts.MSOCnordbord, CSV(HEADING(1)), OPT);
		EXPORT MSOCreadinessfile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_readiness', Athlete360.Layouts.MSOCreadiness, CSV(HEADING(1)), OPT);
		EXPORT MSOCtrainingloadfile := DATASET( Athlete360.util.constants.spray_prefix + 'ms_trainingload', Athlete360.Layouts.MSOCtrainingload, CSV(HEADING(1)), OPT);
		EXPORT WSOCjumpfile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_jump', Athlete360.Layouts.WSOCjump, CSV(HEADING(6), QUOTE(['\'','\"'])), OPT);
		EXPORT WSOCnordbordfile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_nordbord', Athlete360.Layouts.WSOCnordbord, CSV(HEADING(1)), OPT);
		EXPORT WSOCreadinessfile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_readiness', Athlete360.Layouts.WSOCreadiness, CSV(HEADING(1)), OPT);
		EXPORT WSOCtestingfile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_testing', Athlete360.Layouts.WSOCtesting, CSV(HEADING(1)), OPT);
		EXPORT WSOCtrainingloadfile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_trainingload', Athlete360.Layouts.WSOCtrainingload, CSV(HEADING(1)), OPT);
		EXPORT WSOCgymawarefile := DATASET( Athlete360.util.constants.spray_prefix + 'ws_gymaware', Athlete360.Layouts.WSOCgymaware, CSV(HEADING(1)), OPT);		
END;