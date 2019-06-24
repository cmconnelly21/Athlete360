
EXPORT MSOCgymaware := RECORD
		STRING50 Name;
		UNSIGNED4 Date;
		UNSIGNED1 SetNumber;
		STRING Exercise;
		UNSIGNED3 MeanPower_bestrep;
		UNSIGNED3 MeanPower_bestset;
		UNSIGNED3 PeakPower_bestrep;
		UNSIGNED3 PeakPower_bestset;
		DECIMAL5_2 LiftWeight;
		DECIMAL5_2 Heightavg;
		DECIMAL5_2 Height_bestrep;
		DECIMAL10_5 MeanForce_bestrep;
		DECIMAL10_5 MeanForce_bestset;
		DECIMAL5_2 Meanwkg_bestset;
		DECIMAL5_2 MeanVelocity_bestrep;
		DECIMAL5_2 MeanVelocity_bestset;
		DECIMAL10_5 PeakForce_bestrep;
		DECIMAL10_5 PeakForce_bestset;
		DECIMAL5_2 Peakwkg_bestset;
		DECIMAL5_2 PeakVelocity_bestset;
		DECIMAL5_2 PeakVelocity_bestrep;
		DECIMAL10_5 TotalTonnage;
		DECIMAL10_5 TotalWork;
		DECIMAL5_2 Weight_bestset;
		DECIMAL10_5 Workavg;	
	END;