IMPORT Athlete360, STD;

#stored('filedate', '20190816');
//Athlete360.build_athlete360;

// get the layout (processed layout)
//stgLayout := Athlete360.Layouts.MSOCrawgps_stg;


// Athlete360.build_stg.build_WSOCdatefile;
// Athlete360.build_stg.build_MSOCdatefile;
  SEQUENTIAL(
   // Athlete360.spray_build,
 // Athlete360.stg_build;
 athlete360.charts_build, 
  Athlete360.despray_build,
 // Athlete360.files_spray.WSOCrawgpsfile;
 // Athlete360.files_spray.WSOCgpsfile;
// Athlete360.build_stg.build_MSOCgps,
// Athlete360.build_stg.build_MSOCrawgps,
);

// // std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + '2019-06-24', '**');
 
//output(regexfind('([0-9][0-9]*\\-[0-9][0-9]*\\-[0-9]{4})','Session-GABRIEL MACHADO-26-7-2019 Session-GABRIEL MACHADO-26-7-2019 SESSION OVERALL_RawData',1));  

// Athlete360.build_stg.build_WSOCjump
// );
// Athlete360.spray_build;
// Athlete360.files_spray.MSOCrawgpsfile;
// Athlete360.stg_build;

// Athlete360.files_spray.MSOCgpsfile,
// Athlete360.build_stg.build_MSOCgps,
// Athlete360.build_stg.build_MSOCrawgps);
//Athlete360.build_stg.build_WSOCgps;
//Athlete360.build_stg.build_WSOCrawgps;
// Athlete360.files_spray.WSOCdatefile;
// Athlete360.files_spray.MSOCtestingfile;
// Athlete360.files_spray.MSOCgymawarefile;
// Athlete360.files_spray.MSOCjumpfile;
// Athlete360.files_spray.MSOCnordbordfile;
// Athlete360.files_spray.MSOCreadinessfile;
// Athlete360.files_spray.MSOCtrainingloadfile;
// Athlete360.files_spray.WSOCnordbordfile;
// Athlete360.files_spray.WSOCreadinessfile;
// Athlete360.files_spray.WSOCtestingfile;
// Athlete360.files_spray.WSOCtrainingloadfile;
// Athlete360.files_spray.WSOCgymawarefile;
// Athlete360.files_spray.WSOCjumpfile;
// Athlete360.files_spray.athleteinfofile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
// completestgdata := join(finalStageData,

// Athlete360.files_stg.Athleteinfo_stgfile,

// Athlete360.files_spray.WSOCjumpfile;
// Athlete360.files_stg.WSOCjump_stgfile;
// Athlete360.files_spray.MSOCjumpfile;
// Athlete360.files_stg.MSOCjump_stgfile;
// Athlete360.files_spray.WSOCgymawarefile;
// Athlete360.files_stg.WSOCgymaware_stgfile;
// Athlete360.files_spray.MSOCgymawarefile;
// Athlete360.files_stg.MSOCgymaware_stgfile;
// Athlete360.files_spray.WSOCnordbordfile;
// Athlete360.files_stg.WSOCnordbord_stgfile;
// Athlete360.files_spray.MSOCnordbordfile;
// Athlete360.files_stg.MSOCnordbord_stgfile;
// Athlete360.files_spray.WSOCreadinessfile;
// Athlete360.files_stg.WSOCreadiness_stgfile;
// Athlete360.files_spray.MSOCreadinessfile;
// Athlete360.files_stg.MSOCreadiness_stgfile;
// Athlete360.files_spray.WSOCtrainingloadfile;
// Athlete360.files_stg.WSOCtrainingload_stgfile;
// Athlete360.files_spray.MSOCtrainingloadfile;
// Athlete360.files_stg.MSOCtrainingload_stgfile;
// Athlete360.files_spray.WSOCtestingfile;
// Athlete360.files_stg.WSOCtesting_stgfile;
// Athlete360.files_spray.MSOCtestingfile;
// Athlete360.files_stg.MSOCtesting_stgfile;
 // Athlete360.files_spray.MSOCgpsfile;
 // TABLE(Athlete360.files_stg.MSOCgps_stgfile, {name, date}, name, date);
 // Athlete360.files_spray.MSOCrawgpsfile;
 // TABLE(Athlete360.files_stg.MSOCrawgps_stgfile, {name, date}, name, date);
 //Athlete360.files_spray.athleteinfofile;
 //Athlete360.files_spray.WSOCdatefile;

// SORT(Intern.RawGPS.processedfile, Name, elapsedtime)[1..1000];
