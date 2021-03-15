Import STD, Athlete360;

String fileDate := (String) std.Date.Today() : STORED('filedate');

folderDate := Std.Date.DateToString((Unsigned4)fileDate, '%Y-%m-%d');

fileList := std.file.RemoteDirectory('10.0.0.220', '/var/lib/HPCCSystems/mydropzone/Athlete360/' + folderDate, '**');

cleanname(String name) := Std.str.FindReplace(Std.str.FindReplace(std.str.tolowercase(name), 'athlete360_', ''), '.csv', '');
		
newRec := RECORD
    string name;
    string cleanName;
END;

newRec getFullDtls(fileList L) := TRANSFORM
		
		    cleanName2 := regexfind('([^0-9]+)_([^0-9]+)_([^0-9]+)', L.name, 0);
		
				athleteName := STD.STR.FINDREPLACE(regexfind('(\\-[A-Za-z]* [A-Za-z]*\\-)' , L.name, 1), '-', '');
		
				teamName := IF(athleteName = '', '', Athlete360.files_stg.Athleteinfo_stgfile(STD.STR.TOUPPERCASE(name) = STD.STR.TOUPPERCASE(trim(athleteName, LEFT, RIGHT)))[1].team);

        SELF.cleanName := cleanname(Map(teamName ='' and cleanName2 <> '' => 'wbb_gps',
																				teamName <> '' => IF(STD.str.Tolowercase(teamname) = 'wsoc', 'ws_rawgps', 'ms_rawgps'),
																				L.name));
																				

        SELF := L;
END;

fileListNew := Global(PROJECT(NOTHOR(fileList), getFullDtLs(LEFT)), FEW);

spray_prefix := '~athlete360::in::spray::';

sprayFiles := NOTHOR(Apply(fileListNew,
                Std.file.SprayVariable('10.0.0.220',
                    '/var/lib/HPCCSystems/mydropzone/Athlete360/'  + folderDate + '/' + name,
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

addFiles := nothor(APPLY(fileListNew, Athlete360.util.fn_promote_file(spray_prefix , name, cleanname)));

// addToSuper := APPLY(GLOBAL(NOTHOR(fileList)), Athlete360.util.fn_promote_file(spray_prefix , name));

EXPORT spray_build := SEQUENTIAL(output(fileListNew), output(folderDate),  sprayFiles, addFiles);