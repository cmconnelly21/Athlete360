IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.MSOCjumpfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.MSOCjump_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractstandingweighttrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'standingweight';
     self.trial1 := (decimal10_5) L.standingweight_trial1;
     self.trial2 := (decimal10_5) L.standingweight_trial2;
     self.trial3 := (decimal10_5) L.standingweight_trial3;
		 self.trial4 := (decimal10_5) L.standingweight_trial4;
		 self.trial5 := (decimal10_5) L.standingweight_trial5;
     self := L;
   end;
   
   stgLayout extractRSImodtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'RSImod';
     self.trial1 := (decimal10_5) L.RSImod_trial1;
     self.trial2 := (decimal10_5) L.RSImod_trial2;
     self.trial3 := (decimal10_5) L.RSImod_trial3;
		 self.trial4 := (decimal10_5) L.RSImod_trial4;
		 self.trial5 := (decimal10_5) L.RSImod_trial5;
     self := L;
   end;
	 
   stgLayout extractJumpheight_impmomtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'Jumpheight_impmom';
     self.trial1 := (decimal10_5) L.Jumpheight_impmom_trial1;
     self.trial2 := (decimal10_5) L.Jumpheight_impmom_trial2;
     self.trial3 := (decimal10_5) L.Jumpheight_impmom_trial3;
		 self.trial4 := (decimal10_5) L.Jumpheight_impmom_trial4;
		 self.trial5 := (decimal10_5) L.Jumpheight_impmom_trial5;
     self := L;
   end;
   
   stgLayout extractEccdecelRFDtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'EccdecelRFD';
     self.trial1 := (decimal10_5) L.EccdecelRFD_trial1;
     self.trial2 := (decimal10_5) L.EccdecelRFD_trial2;
     self.trial3 := (decimal10_5) L.EccdecelRFD_trial3;
		 self.trial4 := (decimal10_5) L.EccdecelRFD_trial4;
		 self.trial5 := (decimal10_5) L.EccdecelRFD_trial5;
     self := L;
   end;
   
   stgLayout extractConRFDRtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ConRFDR';
     self.trial1 := (decimal10_5) L.ConRFDR_trial1;
     self.trial2 := (decimal10_5) L.ConRFDR_trial2;
     self.trial3 := (decimal10_5) L.ConRFDR_trial3;
		 self.trial4 := (decimal10_5) L.ConRFDR_trial4;
		 self.trial5 := (decimal10_5) L.ConRFDR_trial5;
     self := L;
   end;
   
   stgLayout extractConRFDLtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ConRFDL';
     self.trial1 := (decimal10_5) L.ConRFDL_trial1;
     self.trial2 := (decimal10_5) L.ConRFDL_trial2;
     self.trial3 := (decimal10_5) L.ConRFDL_trial3;
		 self.trial4 := (decimal10_5) L.ConRFDL_trial4;
		 self.trial5 := (decimal10_5) L.ConRFDL_trial5;
     self := L;
   end;
   
   stgLayout extractConRFDasymmetrytrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'ConRFDasymmetry';
     self.trial1 := (decimal10_5) L.ConRFDasymmetry_trial1;
     self.trial2 := (decimal10_5) L.ConRFDasymmetry_trial2;
     self.trial3 := (decimal10_5) L.ConRFDasymmetry_trial3;
		 self.trial4 := (decimal10_5) L.ConRFDasymmetry_trial4;
		 self.trial5 := (decimal10_5) L.ConRFDasymmetry_trial5;
     self := L;
   end;
   
   stgLayout extractpeaklanding_forceRtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_forceR';
     self.trial1 := (decimal10_5) L.peaklanding_forceR_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_forceR_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_forceR_trial3;
		 self.trial4 := (decimal10_5) L.peaklanding_forceR_trial4;
		 self.trial5 := (decimal10_5) L.peaklanding_forceR_trial5;
     self := L;
   end;
   
   stgLayout extractpeaklanding_forceLtrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_forceL';
     self.trial1 := (decimal10_5) L.peaklanding_forceL_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_forceL_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_forceL_trial3;
		 self.trial4 := (decimal10_5) L.peaklanding_forceL_trial4;
		 self.trial5 := (decimal10_5) L.peaklanding_forceL_trial5;
     self := L;
   end;
   
   stgLayout extractpeaklanding_forceasymmetrytrials(ATHLETE360.Layouts.MSOCjump L) := transform
     self.date := std.date.FromStringToDate(L.date[1..10] ,'%d/%m/%Y');
     self.time := std.date.FromStringToDate(L.date[11..16] ,'%H:%M');
		 self.trialname := 'peaklanding_forceasymmetry';
     self.trial1 := (decimal10_5) L.peaklanding_forceasymmetry_trial1;
     self.trial2 := (decimal10_5) L.peaklanding_forceasymmetry_trial2;
     self.trial3 := (decimal10_5) L.peaklanding_forceasymmetry_trial3;
		 self.trial4 := (decimal10_5) L.peaklanding_forceasymmetry_trial4;
		 self.trial5 := (decimal10_5) L.peaklanding_forceasymmetry_trial5;
     self := L;
   end;
   

   cleanedSprayFile :=
         PROJECT(sprayFile, extractstandingweighttrials(LEFT) ) + 
         PROJECT(sprayFile, extractRSImodtrials(LEFT)) + 
         PROJECT(sprayFile, extractJumpheight_impmomtrials(LEFT)) + 
         PROJECT(sprayFile, extractEccdecelRFDtrials(LEFT)) + 
         PROJECT(sprayFile, extractConRFDRtrials(LEFT)) + 
         PROJECT(sprayFile, extractConRFDLtrials(LEFT)) +
				 PROJECT(sprayFile, extractConRFDasymmetrytrials(LEFT)) +
         PROJECT(sprayFile, extractpeaklanding_forceRtrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaklanding_forceLtrials(LEFT)) + 
         PROJECT(sprayFile, extractpeaklanding_forceasymmetrytrials(LEFT));
// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.MSOCjump_stgfile,
            NAME, DATE, -wuid),
        NAME, DATE
    );
mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(finalStageData, mapfile,
    left.name = right.name,
    transform(stgLayout,
        self.athleteid := right.athleteid, self.wuid := workunit,self.wuid := workunut,
        self := left
    ),
    LEFT OUTER
);
// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_MSOCjump := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCjump_name, completestgdata);