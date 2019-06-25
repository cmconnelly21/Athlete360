Import Athlete360, std;

#stored('filedate', '20190624');
// Athlete360.spray_build ;

// Athlete360.DataPatterns.profile(Athlete360.files_spray.WSOCdatefile, features := '\'fill_rate,best_ecl_types\'');

SEQUENTIAL(
    Athlete360.FileSpray;

// std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + '2019-06-24', '**');

Athlete360.build_stg.build_WSOCjump
);