import athlete360, STD;

desprayMe(rawdata, filename) := functionMacro
  
   
    return Sequential(
      
      	OUTPUT(rawdata,,'~Athlete360::OUT::despray::' + filename,CSV(HEADING(1)),overwrite),


    	STD.File.DeSpray('~Athlete360::OUT::despray::' + filename,
                '10.0.0.220',
            '/var/lib/HPCCSystems/mydropzone/athlete360/exports/' + filename + '.csv',
          ,,,true)
      );

endMacro;

// desprayMe(Athlete360.files_stg.MSOCgps_stgfile, 'MSOCgps');
// desprayMe(Athlete360.files_stg.MSOCrawgps_stgfile, 'MSOCrawgps');
desprayMe(Athlete360.files_stg.MSOCgpsnum_stgfile, 'MSOCgpsnum');
desprayMe(Athlete360.files_stg.MSOCreadiness_stgfile, 'MSOCreadiness');
desprayMe(Athlete360.files_stg.MSOCreadinessnum_stgfile, 'MSOCreadinessnum');
desprayMe(Athlete360.files_stg.MSOCtesting_stgfile, 'MSOCtesting');
desprayMe(Athlete360.files_stg.MSOCtrainingload_stgfile, 'MSOCtrainingload');
desprayMe(Athlete360.files_stg.MSOCtrainingloadnum_stgfile, 'MSOCtrainingloadnum');