EXPORT fn_promote_file(string prefix, String filename) := FUNCTION

    import STD;
    
    greatGrandfather := prefix + 'greatgrandfather::' + filename;

    grandfather := prefix + 'grandfather::' + filename;

    father := prefix + 'father::' + filename;

    super := prefix +  filename;

    sub := prefix + filename + '_' + workunit;

    RETURN  STD.File.PromoteSuperFileList(
            [super, father, grandfather, greatGrandfather],
            sub
    );
END;