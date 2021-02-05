EXPORT constants := MODULE

    EXPORT spray_prefix := '~athlete360::in::spray::';

    EXPORT stg_prefix := '~athlete360::in::stg::';

    EXPORT chart_prefix := '~Athlete360::OUT::Charts::';

    EXPORT landingzone_folder := '/var/lib/HPCCSystems/mydropzone/Athlete360/';    

    EXPORT despray_prefix := '~athlete360::out::despray';

    EXPORT chart_out_MSOCgpsfindpeaks := 'MSOCgpsfindpeaks';
    EXPORT chart_out_WSOCgpsfindpeaks := 'WSOCgpsfindpeaks';
    EXPORT chart_out_MSOCrollingave := 'MSOCrollingave';
    EXPORT chart_out_WSOCrollingave := 'WSOCrollingave';
		EXPORT chart_out_WSOCGPSgamereport := 'WSOCgpsgamereport';
		EXPORT chart_out_MSOCGPSgamereport := 'MSOCgpsgamereport';
		EXPORT chart_out_WSOCGPSdistance := 'WSOCgpsdistance';
		EXPORT chart_out_MSOCGPSdistance := 'MSOCgpsdistance';


    EXPORT landingzone_ip  := '10.0.0.220';
    
    EXPORT WSOCdate_name := 'ws_dates';
		EXPORT MSOCdate_name := 'ms_dates';
    EXPORT MSOCtesting_name := 'ms_testing';
    EXPORT MSOCgps_name := 'ms_gps';
		EXPORT MSOCgpsNUM_name := 'ms_gpsNUM';
		EXPORT MSOCrawgps_name := 'ms_rawgps';
		EXPORT WSOCgps_name := 'ws_gps';
		EXPORT WSOCrawgps_name := 'ws_rawgps';
    EXPORT MSOCgymaware_name := 'ms_gymaware';
    EXPORT MSOCjump_name := 'ms_jump';
    EXPORT MSOCnordbord_name := 'ms_nordbord';
    EXPORT MSOCreadiness_name := 'ms_readiness';
		EXPORT MSOCreadinessNUM_name := 'ms_readinessNUM';
    EXPORT MSOCtrainingload_name := 'ms_trainingload';
    EXPORT WSOCjump_name := 'ws_jump';
    EXPORT WSOCnordbord_name := 'ws_nordbord';
    EXPORT WSOCreadiness_name := 'ws_readiness';
    EXPORT WSOCtesting_name := 'ws_testing';
    EXPORT WSOCtrainingload_name := 'ws_trainingload';
		EXPORT MSOCtrainingloadNUM_name := 'ms_trainingloadNUM';
    EXPORT WSOCgymaware_name := 'ws_gymaware';
		EXPORT Athleteinfo_name := 'athleteinfo';
		EXPORT SOCdrills_name := 'soc_drills';
		EXPORT WBBgps_name := 'wbb_gps';

END;
