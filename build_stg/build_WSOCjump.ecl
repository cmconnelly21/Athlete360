IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.WSOCjumpfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.WSOCjump_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractRSItrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'RSI';
     self.trial1 := (decimal10_5) L.rsi_trial1;
     self.trial2 := (decimal10_5) L.rsi_trial2;
     self.trial3 := (decimal10_5) L.rsi_trial3;
     self := L;
   end;
   
   stgLayout extractRSI_jhtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'RSI_jh';
     self.trial1 := (decimal10_5) L.rsi_jh_trial1;
     self.trial2 := (decimal10_5) L.rsi_jh_trial2;
     self.trial3 := (decimal10_5) L.rsi_jh_trial3;
     self := L;
   end;
   
   stgLayout extractJumpheight_impmomtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Jumpheight_impmom';
     self.trial1 := (decimal10_5) L.Jumpheight_impmom_trial1;
     self.trial2 := (decimal10_5) L.Jumpheight_impmom_trial2;
     self.trial3 := (decimal10_5) L.Jumpheight_impmom_trial3;
     self := L;
   end;
   
   stgLayout extractActiveStiffnesstrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ActiveStiffness';
     self.trial1 := (decimal10_5) L.ActiveStiffness_trial1;
     self.trial2 := (decimal10_5) L.ActiveStiffness_trial2;
     self.trial3 := (decimal10_5) L.ActiveStiffness_trial3;
     self := L;
   end;
   
   stgLayout extractActiveStiffness_indextrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ActiveStiffness_index';
     self.trial1 := (decimal10_5) L.ActiveStiffness_index_trial1;
     self.trial2 := (decimal10_5) L.ActiveStiffness_index_trial2;
     self.trial3 := (decimal10_5) L.ActiveStiffness_index_trial3;
     self := L;
   end;
   
   stgLayout extractImpulse_concentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Impulse_concentric';
     self.trial1 := (decimal10_5) L.Impulse_concentric_trial1;
     self.trial2 := (decimal10_5) L.Impulse_concentric_trial2;
     self.trial3 := (decimal10_5) L.Impulse_concentric_trial3;
     self := L;
   end;
   
   stgLayout extractmeanforce_concentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanforce_concentric';
     self.trial1 := (decimal10_5) L.meanforce_concentric_trial1;
     self.trial2 := (decimal10_5) L.meanforce_concentric_trial2;
     self.trial3 := (decimal10_5) L.meanforce_concentric_trial3;
     self := L;
   end;
   
   stgLayout extractmeanwkg_concentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanwkg_concentric';
     self.trial1 := (decimal10_5) L.meanwkg_concentric_trial1;
     self.trial2 := (decimal10_5) L.meanwkg_concentric_trial2;
     self.trial3 := (decimal10_5) L.meanwkg_concentric_trial3;
     self := L;
   end;
   
   stgLayout extractmeanpower_concentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanpower_concentric';
     self.trial1 := (decimal10_5) L.meanpower_concentric_trial1;
     self.trial2 := (decimal10_5) L.meanpower_concentric_trial2;
     self.trial3 := (decimal10_5) L.meanpower_concentric_trial3;
     self := L;
   end;
   
   stgLayout extractpeakvelocity_concentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakvelocity_concentric';
     self.trial1 := (decimal10_5) L.peakvelocity_concentric_trial1;
     self.trial2 := (decimal10_5) L.peakvelocity_concentric_trial2;
     self.trial3 := (decimal10_5) L.peakvelocity_concentric_trial3;
     self := L;
   end;
   
   stgLayout extractcontacttimetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'contacttime';
     self.trial1 := (decimal10_5) L.contacttime_trial1;
     self.trial2 := (decimal10_5) L.contacttime_trial2;
     self.trial3 := (decimal10_5) L.contacttime_trial3;
     self := L;
   end;
   
   stgLayout extractcountermvmt_depthtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'countermvmt_depth';
     self.trial1 := (decimal10_5) L.countermvmt_depth_trial1;
     self.trial2 := (decimal10_5) L.countermvmt_depth_trial2;
     self.trial3 := (decimal10_5) L.countermvmt_depth_trial3;
     self := L;
   end;
   
   stgLayout extractdropheighttrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'dropheight';
     self.trial1 := (decimal10_5) L.dropheight_trial1;
     self.trial2 := (decimal10_5) L.dropheight_trial2;
     self.trial3 := (decimal10_5) L.dropheight_trial3;
     self := L;
   end;
   
   stgLayout extractdroplandingtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'droplanding';
     self.trial1 := (decimal10_5) L.droplanding_trial1;
     self.trial2 := (decimal10_5) L.droplanding_trial2;
     self.trial3 := (decimal10_5) L.droplanding_trial3;
     self := L;
   end;
   
   stgLayout extractecc_con_meanforceratiotrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ecc_con_meanforceratio';
     self.trial1 := (decimal10_5) L.ecc_con_meanforceratio_trial1;
     self.trial2 := (decimal10_5) L.ecc_con_meanforceratio_trial2;
     self.trial3 := (decimal10_5) L.ecc_con_meanforceratio_trial3;
     self := L;
   end;
   
   stgLayout extractimpulse_eccentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'impulse_eccentric';
     self.trial1 := (decimal10_5) L.impulse_eccentric_trial1;
     self.trial2 := (decimal10_5) L.impulse_eccentric_trial2;
     self.trial3 := (decimal10_5) L.impulse_eccentric_trial3;
     self := L;
   end;
   
   stgLayout extractmeanforce_eccentrictrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanforce_eccentric';
     self.trial1 := (decimal10_5) L.meanforce_eccentric_trial1;
     self.trial2 := (decimal10_5) L.meanforce_eccentric_trial2;
     self.trial3 := (decimal10_5) L.meanforce_eccentric_trial3;
     self := L;
   end;
   
   stgLayout extracteffectivedroptrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'effectivedrop';
     self.trial1 := (decimal10_5) L.effectivedrop_trial1;
     self.trial2 := (decimal10_5) L.effectivedrop_trial2;
     self.trial3 := (decimal10_5) L.effectivedrop_trial3;
     self := L;
   end;
   
   stgLayout extractflighttimetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'flighttime';
     self.trial1 := (decimal10_5) L.flighttime_trial1;
     self.trial2 := (decimal10_5) L.flighttime_trial2;
     self.trial3 := (decimal10_5) L.flighttime_trial3;
     self := L;
   end;
   
   stgLayout extractforce_zerovelocitytrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'force_zerovelocity';
     self.trial1 := (decimal10_5) L.force_zerovelocity_trial1;
     self.trial2 := (decimal10_5) L.force_zerovelocity_trial2;
     self.trial3 := (decimal10_5) L.force_zerovelocity_trial3;
     self := L;
   end;
   
   stgLayout extractjumpheight_flighttimetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_flighttime';
     self.trial1 := (decimal10_5) L.jumpheight_flighttime_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_flighttime_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_flighttime_trial3;
     self := L;
   end;
   
   stgLayout extractjumpheight_flighttime_intrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_flighttime_in';
     self.trial1 := (decimal10_5) L.jumpheight_flighttime_in_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_flighttime_in_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_flighttime_in_trial3;
     self := L;
   end;
   
   stgLayout extractjumpheight_impdistrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_impdis';
     self.trial1 := (decimal10_5) L.jumpheight_impdis_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_impdis_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_impdis_trial3;
     self := L;
   end;
   
   stgLayout extractjumpheight_impmom_intrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_impmom_in';
     self.trial1 := (decimal10_5) L.jumpheight_impmom_in_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_impmom_in_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_impmom_in_trial3;
     self := L;
   end;
   
   stgLayout extractMovementstart_peakpowertrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Movementstart_peakpower';
     self.trial1 := (decimal10_5) L.Movementstart_peakpower_trial1;
     self.trial2 := (decimal10_5) L.Movementstart_peakpower_trial2;
     self.trial3 := (decimal10_5) L.Movementstart_peakpower_trial3;
     self := L;
   end;
   
   stgLayout extractforce_peakdriveofftrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'force_peakdriveoff';
     self.trial1 := (decimal10_5) L.force_peakdriveoff_trial1;
     self.trial2 := (decimal10_5) L.force_peakdriveoff_trial2;
     self.trial3 := (decimal10_5) L.force_peakdriveoff_trial3;
     self := L;
   end;
   
   stgLayout extractpeakforce_droplandingtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakforce_droplanding';
     self.trial1 := (decimal10_5) L.peakforce_droplanding_trial1;
     self.trial2 := (decimal10_5) L.peakforce_droplanding_trial2;
     self.trial3 := (decimal10_5) L.peakforce_droplanding_trial3;
     self := L;
   end;
   
   stgLayout extractpeakwkgtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakwkg';
     self.trial1 := (decimal10_5) L.peakwkg_trial1;
     self.trial2 := (decimal10_5) L.peakwkg_trial2;
     self.trial3 := (decimal10_5) L.peakwkg_trial3;
     self := L;
   end;
   
   stgLayout extractpeakpowertrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakpower';
     self.trial1 := (decimal10_5) L.peakpower_trial1;
     self.trial2 := (decimal10_5) L.peakpower_trial2;
     self.trial3 := (decimal10_5) L.peakpower_trial3;
     self := L;
   end;
   
   stgLayout extractimpulse_postivetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'impulse_positive';
     self.trial1 := (decimal10_5) L.impulse_postive_trial1;
     self.trial2 := (decimal10_5) L.impulse_postive_trial2;
     self.trial3 := (decimal10_5) L.impulse_postive_trial3;
     self := L;
   end;
   
   stgLayout extractconcentricstarttrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'concentricstart';
     self.trial1 := (decimal10_5) L.concentricstart_trial1;
     self.trial2 := (decimal10_5) L.concentricstart_trial2;
     self.trial3 := (decimal10_5) L.concentricstart_trial3;
     self := L;
   end;
   
   stgLayout extractverticalvelocity_contacttrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'verticalvelocity_contact';
     self.trial1 := (decimal10_5) L.verticalvelocity_contact_trial1;
     self.trial2 := (decimal10_5) L.verticalvelocity_contact_trial2;
     self.trial3 := (decimal10_5) L.verticalvelocity_contact_trial3;
     self := L;
   end;
   
   stgLayout extractverticalvelocity_takeofftrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'verticalvelocity_takeoff';
     self.trial1 := (decimal10_5) L.verticalvelocity_takeoff_trial1;
     self.trial2 := (decimal10_5) L.verticalvelocity_takeoff_trial2;
     self.trial3 := (decimal10_5) L.verticalvelocity_takeoff_trial3;
     self := L;
   end;
   
   stgLayout extractjumpheight_relativelandingRFDtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_relativelandingRFD';
     self.trial1 := (decimal10_5) L.jumpheight_relativelandingRFD_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_relativelandingRFD_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_relativelandingRFD_trial3;
     self := L;
   end;
   
   stgLayout extractjumpheight_relativepeaklandingforcetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_relativepeaklandingforce';
     self.trial1 := (decimal10_5) L.jumpheight_relativepeaklandingforce_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_relativepeaklandingforce_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_relativepeaklandingforce_trial3;
     self := L;
   end;
   
   stgLayout extractlanding_netpeakforcetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'landing_netpeakforce';
     self.trial1 := (decimal10_5) L.landing_netpeakforce_trial1;
     self.trial2 := (decimal10_5) L.landing_netpeakforce_trial2;
     self.trial3 := (decimal10_5) L.landing_netpeakforce_trial3;
     self := L;
   end;
   
   stgLayout extractlandingRFDtrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'landingRFD';
     self.trial1 := (decimal10_5) L.landingRFD_trial1;
     self.trial2 := (decimal10_5) L.landingRFD_trial2;
     self.trial3 := (decimal10_5) L.landingRFD_trial3;
     self := L;
   end;
   
   stgLayout extractmeanlanding_acceltrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanlanding_accel';
     self.trial1 := (decimal10_5) L.meanlanding_accel_trial1;
     self.trial2 := (decimal10_5) L.meanlanding_accel_trial2;
     self.trial3 := (decimal10_5) L.meanlanding_accel_trial3;
     self := L;
   end;
   
   stgLayout extractmeanlanding_powertrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanlanding_power';
     self.trial1 := (decimal10_5) L.meanlanding_power_trial1;
     self.trial2 := (decimal10_5) L.meanlanding_power_trial2;
     self.trial3 := (decimal10_5) L.meanlanding_power_trial3;
     self := L;
   end;
   
   stgLayout extractmeanlanding_velocitytrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanlanding_velocity';
     self.trial1 := (decimal10_5) L.meanlanding_velocity_trial1;
     self.trial2 := (decimal10_5) L.meanlanding_velocity_trial2;
     self.trial3 := (decimal10_5) L.meanlanding_velocity_trial3;
     self := L;
   end;
   
   stgLayout extractpassivestiffnesstrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'passitvestiffness';
     self.trial1 := (decimal10_5) L.passivestiffness_trial1;
     self.trial2 := (decimal10_5) L.passivestiffness_trial2;
     self.trial3 := (decimal10_5) L.passivestiffness_trial3;
     self := L;
   end;
   
   stgLayout extractpassivestiffness_indextrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'passivestiffness_index';
     self.trial1 := (decimal10_5) L.passivestiffness_index_trial1;
     self.trial2 := (decimal10_5) L.passivestiffness_index_trial2;
     self.trial3 := (decimal10_5) L.passivestiffness_index_trial3;
     self := L;
   end;
   
   stgLayout extractpeakimpactforcetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakimpactforce';
     self.trial1 := (decimal10_5) L.peakimpactforce_trial1;
     self.trial2 := (decimal10_5) L.peakimpactforce_trial2;
     self.trial3 := (decimal10_5) L.peakimpactforce_trial3;
     self := L;
   end;
   
   stgLayout extractpeaklanding_acceltrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_accel';
     self.trial1 := (decimal10_5) L.peaklanding_accel_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_accel_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_accel_trial3;
     self := L;
   end;
   
   stgLayout extractpeaklanding_forcetrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_force';
     self.trial1 := (decimal10_5) L.peaklanding_force_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_force_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_force_trial3;
     self := L;
   end;
   
   stgLayout extractpeaklanding_powertrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_power';
     self.trial1 := (decimal10_5) L.peaklanding_power_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_power_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_power_trial3;
     self := L;
   end;
   
   stgLayout extractpeaklanding_velocitytrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_velocity';
     self.trial1 := (decimal10_5) L.peaklanding_velocity_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_velocity_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_velocity_trial3;
     self := L;
   end;
   
   stgLayout extractpeaktakeoffacceltrials(ATHLETE360.Layouts.WSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaktakeoffaccel';
     self.trial1 := (decimal10_5) L.peaktakeoffaccel_trial1;
     self.trial2 := (decimal10_5) L.peaktakeoffaccel_trial2;
     self.trial3 := (decimal10_5) L.peaktakeoffaccel_trial3;
     self := L;
   end;
   
   
   cleanedSprayFile :=
         PROJECT(sprayFile, extractRSItrials(LEFT) ) + 
         PROJECT(sprayFile, extractRSI_jhtrials(LEFT)) + 
         PROJECT(sprayFile, extractJumpheight_impmomtrials(LEFT)) + 
         PROJECT(sprayFile, extractActiveStiffnesstrials(LEFT)) + 
         PROJECT(sprayFile, extractActiveStiffness_indextrials(LEFT)) + 
         PROJECT(sprayFile, extractImpulse_concentrictrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanforce_concentrictrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanwkg_concentrictrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanpower_concentrictrials(LEFT)) + 
         PROJECT(sprayFile, extractpeakvelocity_concentrictrials(LEFT)) + 
         PROJECT(sprayFile, extractcontacttimetrials(LEFT)) + 
         PROJECT(sprayFile, extractcountermvmt_depthtrials(LEFT)) + 
         PROJECT(sprayFile, extractdropheighttrials(LEFT)) + 
         PROJECT(sprayFile, extractdroplandingtrials(LEFT)) + 
         PROJECT(sprayFile, extractecc_con_meanforceratiotrials(LEFT)) + 
         PROJECT(sprayFile, extractimpulse_eccentrictrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanforce_eccentrictrials(LEFT)) + 
         PROJECT(sprayFile, extracteffectivedroptrials(LEFT)) + 
         PROJECT(sprayFile, extractflighttimetrials(LEFT)) + 
         PROJECT(sprayFile, extractforce_zerovelocitytrials(LEFT)) + 
         PROJECT(sprayFile, extractjumpheight_flighttimetrials(LEFT)) + 
         PROJECT(sprayFile, extractjumpheight_flighttime_intrials(LEFT)) + 
         PROJECT(sprayFile, extractjumpheight_impdistrials(LEFT)) + 
         PROJECT(sprayFile, extractjumpheight_impmom_intrials(LEFT)) + 
         PROJECT(sprayFile, extractMovementstart_peakpowertrials(LEFT)) + 
         PROJECT(sprayFile, extractforce_peakdriveofftrials(LEFT)) + 
         PROJECT(sprayFile, extractpeakforce_droplandingtrials(LEFT)) + 
         PROJECT(sprayFile, extractpeakwkgtrials(LEFT)) + 
         PROJECT(sprayFile, extractpeakpowertrials(LEFT)) + 
         PROJECT(sprayFile, extractimpulse_postivetrials(LEFT)) + 
         PROJECT(sprayFile, extractconcentricstarttrials(LEFT)) + 
         PROJECT(sprayFile, extractverticalvelocity_contacttrials(LEFT)) + 
         PROJECT(sprayFile, extractverticalvelocity_takeofftrials(LEFT)) + 
         PROJECT(sprayFile, extractjumpheight_relativelandingRFDtrials(LEFT)) + 
         PROJECT(sprayFile, extractjumpheight_relativepeaklandingforcetrials(LEFT)) + 
         PROJECT(sprayFile, extractlanding_netpeakforcetrials(LEFT)) + 
         PROJECT(sprayFile, extractlandingRFDtrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanlanding_acceltrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanlanding_powertrials(LEFT)) + 
         PROJECT(sprayFile, extractmeanlanding_velocitytrials(LEFT)) + 
         PROJECT(sprayFile, extractpassivestiffnesstrials(LEFT)) + 
         PROJECT(sprayFile, extractpassivestiffness_indextrials(LEFT)) + 
         PROJECT(sprayFile, extractpeakimpactforcetrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaklanding_acceltrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaklanding_forcetrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaklanding_powertrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaklanding_velocitytrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaktakeoffacceltrials(LEFT));
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.WSOCjump_stgfile,
            NAME, DATE, -wuid),
        NAME, DATE
    );
mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(finalStageData, mapfile,
    left.name = right.name,
    transform(stgLayout,
        self.athleteid := right.athleteid,
        self := left
    )
);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_WSOCjump := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.WSOCjump_name, completestgdata);