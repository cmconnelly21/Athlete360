Import STD, Athlete360;

String fileDate := (String) std.Date.Today() : STORED('filedate');

folderDate := Std.Date.DateToString((Unsigned4)fileDate, '%Y-%m-%d');

folderName := Athlete360.util.constants.landingzone_folder + folderDate;

fileList := std.file.RemoteDirectory(Athlete360.util.constants.landingzone_ip, folderName, '**');

spray_prefix := Athlete360.util.constants.spray_prefix;

sprayFiles := NOTHOR(Apply(fileList, 
                Std.file.SprayVariable(Athlete360.util.constants.landingzone_ip,
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
                Athlete360.util.fn_promote_file(spray_prefix, name )
            )
        );

//EXPORT spray_build := SEQUENTIAL(output(fileList), sprayFiles, spraybuild);
output(fileList)