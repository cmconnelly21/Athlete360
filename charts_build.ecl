IMPORT athlete360;


export charts_build := sequential(
    Athlete360.charts.WSOCrollingave,
		Athlete360.charts.MSOCrollingave,
		Athlete360.charts.MSOCGPSfindpeaks,
		Athlete360.charts.WSOCGPSfindpeaks,
		Athlete360.charts.WSOCGPSgamereport,
		Athlete360.charts.MSOCGPSgamereport,
		Athlete360.charts.WSOCGPSdistance,
		Athlete360.charts.MSOCGPSdistance,
		Athlete360.charts.WBBgpsgamereport,
		Athlete360.charts.WBBgpsgameathletes,
		Athlete360.charts.WBBpracticereport

		
);