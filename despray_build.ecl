import Athlete360;

EXPORT despray_build := PARALLEL(
    Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_WSOCgpsfindpeaks),
    Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_WSOCrollingave),
    Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_MSOCgpsfindpeaks),
    Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_MSOCrollingave),
		Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_MSOCgpsgamereport),
		Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_WSOCgpsgamereport),
		Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_MSOCgpsdistance),
		Athlete360.util.fn_despray(Athlete360.util.constants.stg_prefix +  Athlete360.util.constants.chart_out_WSOCgpsdistance)
);
