Import STD, Athlete360;

String fileDate := (String) std.Date.Today() : STORED('filedate');

folderDate := Std.Date.DateToString((Unsigned4)fileDate, '%Y-%m-%d');

folderName := '/var/lib/HPCCSystems/mydropzone/Athlete360/' + folderDate;

fileList := std.file.RemoteDirectory('10.0.0.220', folderName, '**');

spray_prefix := '~athlete360::in::spray::';

sprayFiles := NOTHOR(Apply(fileList, 
                Std.file.SprayVariable('10.0.0.220',
                    folderName +'/' + name,
                    65536,
                    ',',
                    ,
                    '[\',"]',
                    std.system.Thorlib.group(),
                    spray_prefix + name + '_' + workunit,
                    -1,
                    ,
                    ,
                    TRUE,
                    TRUE,
                    TRUE
                )
            )           
        );

    spraybuild := NOTHOR(Apply(fileList, 
                // STD.File.PromoteSuperFileList([spray_prefix + name], spray_prefix + name + '_' + workunit),
                Athlete360.util.fn_promote_file(spray_prefix, name )
            )
        );

EXPORT spray_build := SEQUENTIAL(output(fileList), sprayFiles, spraybuild);