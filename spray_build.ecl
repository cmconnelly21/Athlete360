Import STD, Athlete360;

String fileDate := (String) std.Date.Today() : STORED('filedate');

folderDate := Std.Date.DateToString((Unsigned4)fileDate, '%Y-%m-%d');

fileList := std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + folderDate, '**');

spray_prefix := '~athlete360::in::spray::';

cleanname(String name) := Std.str.FindReplace(Std.str.FindReplace(std.str.tolowercase(name), 'athlete360_', ''), '.csv', '');

sprayFiles := NOTHOR(Apply(fileList,
            SEQUENTIAL(
                Std.file.SprayVariable('10.0.0.220',
                    '/var/lib/HPCCSystems/mydropzone/Athlete360/'  + folderDate + '/' + cleanname(name),
                    65536,
                    ',',
                    ,
                    '[\',"]',
                    std.system.Thorlib.group(),
                    spray_prefix + cleanname(name) + '_' + workunit,
                    -1,
                    ,
                    ,
                    TRUE,
                    TRUE,
                    TRUE
                )
            )
        )
    );

addToSuper := APPLY(fileList, Athlete360.util.fn_promote_file(spray_prefix , cleanname(name)));

EXPORT spray_build := SEQUENTIAL(output(filelist), output(folderDate), output('/var/lib/HPCCSystems/mydropzone/Athlete360/' + folderDate), sprayFiles, addToSuper );