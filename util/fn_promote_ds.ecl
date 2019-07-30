EXPORT fn_promote_ds(string prefix, String filename, DATASET filedata) := FUNCTION

    import STD;
    
    greatGrandfather := prefix + 'greatgrandfather::' + filename;

    grandfather := prefix + 'grandfather::' + filename;

    father := prefix + 'father::' + filename;

    super := prefix +  filename;

    sub := prefix + filename + '_' + workunit;

    writeFile := OUTPUT(filedata, ,sub , COMPRESSED);

    RETURN SEQUENTIAL(
        writeFile,
        STD.File.PromoteSuperFileList(
            [super, father],
            sub,
            true
        )
    );
    
END;