IMPORT ATHLETE360;
IMPORT STD;
 
EXPORT WSOCcmj := MODULE
   fullData := ATHLETE360.WSOCjump.file;
   
   trialLayout := RECORD
     string30 name;
     string30 test;
     UNSIGNED4 date;
     UNSIGNED4 time;
     string10 bodyweight;
		 string30 trialname;
     decimal10_5 trial1;
     decimal10_5 trial2;
     decimal10_5 trial3;
   end;
   
   trialLayout extractRSItrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'RSI';
     self.trial1 := (decimal10_5) L.rsi_trial1;
     self.trial2 := (decimal10_5) L.rsi_trial2;
     self.trial3 := (decimal10_5) L.rsi_trial3;
     self := L;
   end;
   
   trialLayout extractRSI_jhtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'RSI_jh';
     self.trial1 := (decimal10_5) L.rsi_jh_trial1;
     self.trial2 := (decimal10_5) L.rsi_jh_trial2;
     self.trial3 := (decimal10_5) L.rsi_jh_trial3;
     self := L;
   end;
   
   trialLayout extractJumpheight_impmomtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Jumpheight_impmom';
     self.trial1 := (decimal10_5) L.Jumpheight_impmom_trial1;
     self.trial2 := (decimal10_5) L.Jumpheight_impmom_trial2;
     self.trial3 := (decimal10_5) L.Jumpheight_impmom_trial3;
     self := L;
   end;
   
   trialLayout extractActiveStiffnesstrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ActiveStiffness';
     self.trial1 := (decimal10_5) L.ActiveStiffness_trial1;
     self.trial2 := (decimal10_5) L.ActiveStiffness_trial2;
     self.trial3 := (decimal10_5) L.ActiveStiffness_trial3;
     self := L;
   end;
   
   trialLayout extractActiveStiffness_indextrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ActiveStiffness_index';
     self.trial1 := (decimal10_5) L.ActiveStiffness_index_trial1;
     self.trial2 := (decimal10_5) L.ActiveStiffness_index_trial2;
     self.trial3 := (decimal10_5) L.ActiveStiffness_index_trial3;
     self := L;
   end;
   
   trialLayout extractImpulse_concentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Impulse_concentric';
     self.trial1 := (decimal10_5) L.Impulse_concentric_trial1;
     self.trial2 := (decimal10_5) L.Impulse_concentric_trial2;
     self.trial3 := (decimal10_5) L.Impulse_concentric_trial3;
     self := L;
   end;
   
   trialLayout extractmeanforce_concentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanforce_concentric';
     self.trial1 := (decimal10_5) L.meanforce_concentric_trial1;
     self.trial2 := (decimal10_5) L.meanforce_concentric_trial2;
     self.trial3 := (decimal10_5) L.meanforce_concentric_trial3;
     self := L;
   end;
   
   trialLayout extractmeanwkg_concentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanwkg_concentric';
     self.trial1 := (decimal10_5) L.meanwkg_concentric_trial1;
     self.trial2 := (decimal10_5) L.meanwkg_concentric_trial2;
     self.trial3 := (decimal10_5) L.meanwkg_concentric_trial3;
     self := L;
   end;
   
   trialLayout extractmeanpower_concentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanpower_concentric';
     self.trial1 := (decimal10_5) L.meanpower_concentric_trial1;
     self.trial2 := (decimal10_5) L.meanpower_concentric_trial2;
     self.trial3 := (decimal10_5) L.meanpower_concentric_trial3;
     self := L;
   end;
   
   trialLayout extractpeakvelocity_concentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakvelocity_concentric';
     self.trial1 := (decimal10_5) L.peakvelocity_concentric_trial1;
     self.trial2 := (decimal10_5) L.peakvelocity_concentric_trial2;
     self.trial3 := (decimal10_5) L.peakvelocity_concentric_trial3;
     self := L;
   end;
   
   trialLayout extractcontacttimetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'contacttime';
     self.trial1 := (decimal10_5) L.contacttime_trial1;
     self.trial2 := (decimal10_5) L.contacttime_trial2;
     self.trial3 := (decimal10_5) L.contacttime_trial3;
     self := L;
   end;
   
   trialLayout extractcountermvmt_depthtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'countermvmt_depth';
     self.trial1 := (decimal10_5) L.countermvmt_depth_trial1;
     self.trial2 := (decimal10_5) L.countermvmt_depth_trial2;
     self.trial3 := (decimal10_5) L.countermvmt_depth_trial3;
     self := L;
   end;
   
   trialLayout extractdropheighttrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'dropheight';
     self.trial1 := (decimal10_5) L.dropheight_trial1;
     self.trial2 := (decimal10_5) L.dropheight_trial2;
     self.trial3 := (decimal10_5) L.dropheight_trial3;
     self := L;
   end;
   
   trialLayout extractdroplandingtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'droplanding';
     self.trial1 := (decimal10_5) L.droplanding_trial1;
     self.trial2 := (decimal10_5) L.droplanding_trial2;
     self.trial3 := (decimal10_5) L.droplanding_trial3;
     self := L;
   end;
   
   trialLayout extractecc_con_meanforceratiotrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ecc_con_meanforceratio';
     self.trial1 := (decimal10_5) L.ecc_con_meanforceratio_trial1;
     self.trial2 := (decimal10_5) L.ecc_con_meanforceratio_trial2;
     self.trial3 := (decimal10_5) L.ecc_con_meanforceratio_trial3;
     self := L;
   end;
   
   trialLayout extractimpulse_eccentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'impulse_eccentric';
     self.trial1 := (decimal10_5) L.impulse_eccentric_trial1;
     self.trial2 := (decimal10_5) L.impulse_eccentric_trial2;
     self.trial3 := (decimal10_5) L.impulse_eccentric_trial3;
     self := L;
   end;
   
   trialLayout extractmeanforce_eccentrictrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanforce_eccentric';
     self.trial1 := (decimal10_5) L.meanforce_eccentric_trial1;
     self.trial2 := (decimal10_5) L.meanforce_eccentric_trial2;
     self.trial3 := (decimal10_5) L.meanforce_eccentric_trial3;
     self := L;
   end;
   
   trialLayout extracteffectivedroptrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'effectivedrop';
     self.trial1 := (decimal10_5) L.effectivedrop_trial1;
     self.trial2 := (decimal10_5) L.effectivedrop_trial2;
     self.trial3 := (decimal10_5) L.effectivedrop_trial3;
     self := L;
   end;
   
   trialLayout extractflighttimetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'flighttime';
     self.trial1 := (decimal10_5) L.flighttime_trial1;
     self.trial2 := (decimal10_5) L.flighttime_trial2;
     self.trial3 := (decimal10_5) L.flighttime_trial3;
     self := L;
   end;
   
   trialLayout extractforce_zerovelocitytrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'force_zerovelocity';
     self.trial1 := (decimal10_5) L.force_zerovelocity_trial1;
     self.trial2 := (decimal10_5) L.force_zerovelocity_trial2;
     self.trial3 := (decimal10_5) L.force_zerovelocity_trial3;
     self := L;
   end;
   
   trialLayout extractjumpheight_flighttimetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_flighttime';
     self.trial1 := (decimal10_5) L.jumpheight_flighttime_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_flighttime_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_flighttime_trial3;
     self := L;
   end;
   
   trialLayout extractjumpheight_flighttime_intrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_flighttime_in';
     self.trial1 := (decimal10_5) L.jumpheight_flighttime_in_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_flighttime_in_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_flighttime_in_trial3;
     self := L;
   end;
   
   trialLayout extractjumpheight_impdistrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_impdis';
     self.trial1 := (decimal10_5) L.jumpheight_impdis_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_impdis_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_impdis_trial3;
     self := L;
   end;
   
   trialLayout extractjumpheight_impmom_intrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_impmom_in';
     self.trial1 := (decimal10_5) L.jumpheight_impmom_in_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_impmom_in_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_impmom_in_trial3;
     self := L;
   end;
   
   trialLayout extractMovementstart_peakpowertrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Movementstart_peakpower';
     self.trial1 := (decimal10_5) L.Movementstart_peakpower_trial1;
     self.trial2 := (decimal10_5) L.Movementstart_peakpower_trial2;
     self.trial3 := (decimal10_5) L.Movementstart_peakpower_trial3;
     self := L;
   end;
   
   trialLayout extractforce_peakdriveofftrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'force_peakdriveoff';
     self.trial1 := (decimal10_5) L.force_peakdriveoff_trial1;
     self.trial2 := (decimal10_5) L.force_peakdriveoff_trial2;
     self.trial3 := (decimal10_5) L.force_peakdriveoff_trial3;
     self := L;
   end;
   
   trialLayout extractpeakforce_droplandingtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakforce_droplanding';
     self.trial1 := (decimal10_5) L.peakforce_droplanding_trial1;
     self.trial2 := (decimal10_5) L.peakforce_droplanding_trial2;
     self.trial3 := (decimal10_5) L.peakforce_droplanding_trial3;
     self := L;
   end;
   
   trialLayout extractpeakwkgtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakwkg';
     self.trial1 := (decimal10_5) L.peakwkg_trial1;
     self.trial2 := (decimal10_5) L.peakwkg_trial2;
     self.trial3 := (decimal10_5) L.peakwkg_trial3;
     self := L;
   end;
   
   trialLayout extractpeakpowertrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakpower';
     self.trial1 := (decimal10_5) L.peakpower_trial1;
     self.trial2 := (decimal10_5) L.peakpower_trial2;
     self.trial3 := (decimal10_5) L.peakpower_trial3;
     self := L;
   end;
   
   trialLayout extractimpulse_postivetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'impulse_positive';
     self.trial1 := (decimal10_5) L.impulse_postive_trial1;
     self.trial2 := (decimal10_5) L.impulse_postive_trial2;
     self.trial3 := (decimal10_5) L.impulse_postive_trial3;
     self := L;
   end;
   
   trialLayout extractconcentricstarttrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'concentricstart';
     self.trial1 := (decimal10_5) L.concentricstart_trial1;
     self.trial2 := (decimal10_5) L.concentricstart_trial2;
     self.trial3 := (decimal10_5) L.concentricstart_trial3;
     self := L;
   end;
   
   trialLayout extractverticalvelocity_contacttrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'verticalvelocity_contact';
     self.trial1 := (decimal10_5) L.verticalvelocity_contact_trial1;
     self.trial2 := (decimal10_5) L.verticalvelocity_contact_trial2;
     self.trial3 := (decimal10_5) L.verticalvelocity_contact_trial3;
     self := L;
   end;
   
   trialLayout extractverticalvelocity_takeofftrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'verticalvelocity_takeoff';
     self.trial1 := (decimal10_5) L.verticalvelocity_takeoff_trial1;
     self.trial2 := (decimal10_5) L.verticalvelocity_takeoff_trial2;
     self.trial3 := (decimal10_5) L.verticalvelocity_takeoff_trial3;
     self := L;
   end;
   
   trialLayout extractjumpheight_relativelandingRFDtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_relativelandingRFD';
     self.trial1 := (decimal10_5) L.jumpheight_relativelandingRFD_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_relativelandingRFD_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_relativelandingRFD_trial3;
     self := L;
   end;
   
   trialLayout extractjumpheight_relativepeaklandingforcetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'jumpheight_relativepeaklandingforce';
     self.trial1 := (decimal10_5) L.jumpheight_relativepeaklandingforce_trial1;
     self.trial2 := (decimal10_5) L.jumpheight_relativepeaklandingforce_trial2;
     self.trial3 := (decimal10_5) L.jumpheight_relativepeaklandingforce_trial3;
     self := L;
   end;
   
   trialLayout extractlanding_netpeakforcetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'landing_netpeakforce';
     self.trial1 := (decimal10_5) L.landing_netpeakforce_trial1;
     self.trial2 := (decimal10_5) L.landing_netpeakforce_trial2;
     self.trial3 := (decimal10_5) L.landing_netpeakforce_trial3;
     self := L;
   end;
   
   trialLayout extractlandingRFDtrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'landingRFD';
     self.trial1 := (decimal10_5) L.landingRFD_trial1;
     self.trial2 := (decimal10_5) L.landingRFD_trial2;
     self.trial3 := (decimal10_5) L.landingRFD_trial3;
     self := L;
   end;
   
   trialLayout extractmeanlanding_acceltrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanlanding_accel';
     self.trial1 := (decimal10_5) L.meanlanding_accel_trial1;
     self.trial2 := (decimal10_5) L.meanlanding_accel_trial2;
     self.trial3 := (decimal10_5) L.meanlanding_accel_trial3;
     self := L;
   end;
   
   trialLayout extractmeanlanding_powertrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanlanding_power';
     self.trial1 := (decimal10_5) L.meanlanding_power_trial1;
     self.trial2 := (decimal10_5) L.meanlanding_power_trial2;
     self.trial3 := (decimal10_5) L.meanlanding_power_trial3;
     self := L;
   end;
   
   trialLayout extractmeanlanding_velocitytrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'meanlanding_velocity';
     self.trial1 := (decimal10_5) L.meanlanding_velocity_trial1;
     self.trial2 := (decimal10_5) L.meanlanding_velocity_trial2;
     self.trial3 := (decimal10_5) L.meanlanding_velocity_trial3;
     self := L;
   end;
   
   trialLayout extractpassivestiffnesstrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'passitvestiffness';
     self.trial1 := (decimal10_5) L.passivestiffness_trial1;
     self.trial2 := (decimal10_5) L.passivestiffness_trial2;
     self.trial3 := (decimal10_5) L.passivestiffness_trial3;
     self := L;
   end;
   
   trialLayout extractpassivestiffness_indextrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'passivestiffness_index';
     self.trial1 := (decimal10_5) L.passivestiffness_index_trial1;
     self.trial2 := (decimal10_5) L.passivestiffness_index_trial2;
     self.trial3 := (decimal10_5) L.passivestiffness_index_trial3;
     self := L;
   end;
   
   trialLayout extractpeakimpactforcetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peakimpactforce';
     self.trial1 := (decimal10_5) L.peakimpactforce_trial1;
     self.trial2 := (decimal10_5) L.peakimpactforce_trial2;
     self.trial3 := (decimal10_5) L.peakimpactforce_trial3;
     self := L;
   end;
   
   trialLayout extractpeaklanding_acceltrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_accel';
     self.trial1 := (decimal10_5) L.peaklanding_accel_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_accel_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_accel_trial3;
     self := L;
   end;
   
   trialLayout extractpeaklanding_forcetrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_force';
     self.trial1 := (decimal10_5) L.peaklanding_force_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_force_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_force_trial3;
     self := L;
   end;
   
   trialLayout extractpeaklanding_powertrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_power';
     self.trial1 := (decimal10_5) L.peaklanding_power_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_power_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_power_trial3;
     self := L;
   end;
   
   trialLayout extractpeaklanding_velocitytrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_velocity';
     self.trial1 := (decimal10_5) L.peaklanding_velocity_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_velocity_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_velocity_trial3;
     self := L;
   end;
   
   trialLayout extractpeaktakeoffacceltrials(ATHLETE360.WSOCjump.file L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaktakeoffaccel';
     self.trial1 := (decimal10_5) L.peaktakeoffaccel_trial1;
     self.trial2 := (decimal10_5) L.peaktakeoffaccel_trial2;
     self.trial3 := (decimal10_5) L.peaktakeoffaccel_trial3;
     self := L;
   end;
   
   
   Export Processedfile :=

         PROJECT(fullData, extractRSItrials(LEFT) ) + 
         PROJECT(fullData, extractRSI_jhtrials(LEFT)) + 
         PROJECT(fullData, extractJumpheight_impmomtrials(LEFT)) + 
         PROJECT(fullData, extractActiveStiffnesstrials(LEFT)) + 
         PROJECT(fullData, extractActiveStiffness_indextrials(LEFT)) + 
         PROJECT(fullData, extractImpulse_concentrictrials(LEFT)) + 
         PROJECT(fullData, extractmeanforce_concentrictrials(LEFT)) + 
         PROJECT(fullData, extractmeanwkg_concentrictrials(LEFT)) + 
         PROJECT(fullData, extractmeanpower_concentrictrials(LEFT)) + 
         PROJECT(fullData, extractpeakvelocity_concentrictrials(LEFT)) + 
         PROJECT(fullData, extractcontacttimetrials(LEFT)) + 
         PROJECT(fullData, extractcountermvmt_depthtrials(LEFT)) + 
         PROJECT(fullData, extractdropheighttrials(LEFT)) + 
         PROJECT(fullData, extractdroplandingtrials(LEFT)) + 
         PROJECT(fullData, extractecc_con_meanforceratiotrials(LEFT)) + 
         PROJECT(fullData, extractimpulse_eccentrictrials(LEFT)) + 
         PROJECT(fullData, extractmeanforce_eccentrictrials(LEFT)) + 
         PROJECT(fullData, extracteffectivedroptrials(LEFT)) + 
         PROJECT(fullData, extractflighttimetrials(LEFT)) + 
         PROJECT(fullData, extractforce_zerovelocitytrials(LEFT)) + 
         PROJECT(fullData, extractjumpheight_flighttimetrials(LEFT)) + 
         PROJECT(fullData, extractjumpheight_flighttime_intrials(LEFT)) + 
         PROJECT(fullData, extractjumpheight_impdistrials(LEFT)) + 
         PROJECT(fullData, extractjumpheight_impmom_intrials(LEFT)) + 
         PROJECT(fullData, extractMovementstart_peakpowertrials(LEFT)) + 
         PROJECT(fullData, extractforce_peakdriveofftrials(LEFT)) + 
         PROJECT(fullData, extractpeakforce_droplandingtrials(LEFT)) + 
         PROJECT(fullData, extractpeakwkgtrials(LEFT)) + 
         PROJECT(fullData, extractpeakpowertrials(LEFT)) + 
         PROJECT(fullData, extractimpulse_postivetrials(LEFT)) + 
         PROJECT(fullData, extractconcentricstarttrials(LEFT)) + 
         PROJECT(fullData, extractverticalvelocity_contacttrials(LEFT)) + 
         PROJECT(fullData, extractverticalvelocity_takeofftrials(LEFT)) + 
         PROJECT(fullData, extractjumpheight_relativelandingRFDtrials(LEFT)) + 
         PROJECT(fullData, extractjumpheight_relativepeaklandingforcetrials(LEFT)) + 
         PROJECT(fullData, extractlanding_netpeakforcetrials(LEFT)) + 
         PROJECT(fullData, extractlandingRFDtrials(LEFT)) + 
         PROJECT(fullData, extractmeanlanding_acceltrials(LEFT)) + 
         PROJECT(fullData, extractmeanlanding_powertrials(LEFT)) + 
         PROJECT(fullData, extractmeanlanding_velocitytrials(LEFT)) + 
         PROJECT(fullData, extractpassivestiffnesstrials(LEFT)) + 
         PROJECT(fullData, extractpassivestiffness_indextrials(LEFT)) + 
         PROJECT(fullData, extractpeakimpactforcetrials(LEFT)) + 
         PROJECT(fullData, extractpeaklanding_acceltrials(LEFT)) + 
         PROJECT(fullData, extractpeaklanding_forcetrials(LEFT)) + 
         PROJECT(fullData, extractpeaklanding_powertrials(LEFT)) + 
         PROJECT(fullData, extractpeaklanding_velocitytrials(LEFT)) + 
         PROJECT(fullData, extractpeaktakeoffacceltrials(LEFT));
END;