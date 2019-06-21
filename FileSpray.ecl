Import STD;

String fileDate := (String) std.Date.Today() : STORED('filedate');

folderDate := Std.Date.DateToString((Unsigned4)fileDate, '%Y-%m-%d');

fileList := std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + folderDate, '**');

spray_prefix := '~athlete360::in::spray::';

sprayFiles := Apply(fileList, 
            SEQUENTIAL(
                Std.file.SprayVariable('10.0.0.220',
                    '/var/lib/HPCCSystems/mydropzone/Athlete360/' + name,
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
                ),
                STD.File.PromoteSuperFileList([spray_prefix + name], spray_prefix + name + '_' + workunit)
            )
);

EXPORT FileSpray := SEQUENTIAL(output(fileList), sprayFiles);