Import Athlete360, Intern, std;

#stored('filedate', '20190805');
//Athlete360.build_athlete360;

// Athlete360.DataPatterns.profile(Athlete360.files_spray.WSOCdatefile, features := '\'fill_rate,best_ecl_types\'');

 // SEQUENTIAL(
  // Athlete360.spray_build,
	// Athlete360.stg_build);

// // std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + '2019-06-24', '**');

// Athlete360.build_stg.build_WSOCjump
// );
//Athlete360.spray_build;
//output(Athlete360.files_spray.MSOCrawgpsfile);
// Athlete360.stg_build;

//Athlete360.build_stg.build_MSOCgps;
Athlete360.build_stg.build_MSOCrawgps;
//Athlete360.build_stg.build_WSOCgps;
//Athlete360.build_stg.build_WSOCrawgps;
// Athlete360.files_spray.WSOCdatefile;
// Athlete360.files_spray.MSOCtestingfile;
// Athlete360.files_spray.MSOCgpsfile;
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

// Athlete360.files_stg.WSOCdate_stgfile;
// Athlete360.files_stg.MSOCtesting_stgfile;
// Athlete360.files_stg.MSOCgps_stgfile;
// Athlete360.files_stg.MSOCgymaware_stgfile;
// Athlete360.files_stg.MSOCjump_stgfile;
// Athlete360.files_stg.MSOCnordbord_stgfile;
// Athlete360.files_stg.MSOCreadiness_stgfile;
// Athlete360.files_stg.MSOCtrainingload_stgfile;
// Athlete360.files_stg.WSOCjump_stgfile;
// Athlete360.files_stg.WSOCnordbord_stgfile;
// Athlete360.files_stg.WSOCreadiness_stgfile;
// Athlete360.files_stg.WSOCtesting_stgfile;
// Athlete360.files_stg.WSOCtrainingload_stgfile;
// Athlete360.files_stg.WSOCgymaware_stgfile;
// Athlete360.files_stg.athleteinfo_stgfile;

//Athlete360.stg_build;

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
 //Athlete360.files_spray.MSOCgpsfile;
 //Athlete360.files_stg.MSOCgps_stgfile;
 //Athlete360.files_spray.MSOCrawgpsfile;
 //Athlete360.files_stg.MSOCrawgps_stgfile;
 //Athlete360.files_spray.athleteinfofile;
 //Athlete360.files_spray.WSOCdatefile;

//SORT(Intern.RawGPS.processedfile, Name, elapsedtime)[1..1000];