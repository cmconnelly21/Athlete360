EXPORT fn_promote_file(string prefix, String filename) := FUNCTION

    import STD;

    backup := prefix + 'backup::' + filename;

    super := prefix +  filename;

    sub := prefix + filename + '_' + workunit;

    RETURN  STD.File.PromoteSuperFileList(
            [super, backup],
            sub,
            true
    );
END;