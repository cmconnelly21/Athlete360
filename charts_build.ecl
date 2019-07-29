IMPORT athlete360;


export charts_build := sequential(
    Athlete360.charts.WSOCrollingave,
		Athlete360.charts.MSOCrollingave,
		Athlete360.charts.MSOCGPSfindpeaks,
		Athlete360.charts.WSOCGPSfindpeaks

		
);