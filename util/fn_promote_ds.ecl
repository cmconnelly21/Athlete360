EXPORT fn_promote_ds(string prefix, String filename, DATASET filedata) := FUNCTION

    import STD, Athlete360;
    
    backup := prefix + 'backup::' + filename;

    super := prefix +  filename;

    sub := prefix + filename + '_' + workunit;

    desprayFileName 	:= Athlete360.util.constants.despray_prefix + '::'+ filename;		

    writeFile := OUTPUT(filedata, ,sub , COMPRESSED);

    writeDesprayfile := output(filedata, , desprayFileName, CSV(heading(0), SEPARATOR(','), TERMINATOR('\n'), MAXLENGTH(10240)), overwrite, compressed);

    RETURN SEQUENTIAL(
        writeFile,
        writeDesprayfile,
        STD.File.PromoteSuperFileList(
            [super, backup],
            sub,
            true
        )
    );
    
END;