Import STD, Athlete360;

String fileDate := (String) std.Date.Today() : STORED('filedate');

folderDate := Std.Date.DateToString((Unsigned4)fileDate, '%Y-%m-%d');

fileList := NOTHOR(std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + folderDate, '**'));

spray_prefix := '~athlete360::in::spray::';

cleanname(String name) := Std.str.FindReplace(Std.str.FindReplace(std.str.tolowercase(name), 'athlete360_', ''), '.csv', '');

sprayFiles := Apply(GLOBAL(project(fileList, transform({string name, string cleanname}, self.cleanname := cleanname(left.name);self:= left)), FEW),
            SEQUENTIAL(
                Std.file.SprayVariable('10.0.0.220',
                    '/var/lib/HPCCSystems/mydropzone/Athlete360/'  + folderDate + '/' + cleanname,
                    65536,
                    ',',
                    ,
                    '[\',"]',
                    std.system.Thorlib.group(),
                    spray_prefix + cleanname + '_' + workunit,
                    -1,
                    ,
                    ,
                    TRUE,
                    TRUE,
                    TRUE
                ),
            Athlete360.util.fn_promote_file(spray_prefix , cleanname)
        )
);

EXPORT FileSpray := SEQUENTIAL(sprayFiles );