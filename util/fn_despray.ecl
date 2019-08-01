import std.file;
import std, Athlete360;

EXPORT fn_despray(string filename) := function
	
    remote_file 	:= Athlete360.util.constants.landingzone_folder + 'out/charts/' + filename;

    thor_filename 	:= Athlete360.util.constants.despray_folder + '::'+ std.str.reverse(std.str.splitwords(std.str.reverse(filename), '::')[1]);	
	
	dspray :=	file.despray(thor_filename, 
												 Athlete360.util.constants.landingzone_ip,
												 remote_file + '.csv'
												 ,,,,true);
								 
	fileexists := File.FileExists(thor_filename);
    		
	return if(fileexists, dspray, output('MISSING ' + thor_filename));

end;

