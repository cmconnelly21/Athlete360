EXPORT fn_promote_file(string prefix, String filename, String cleanName) := FUNCTION

    import Athlete360,STD;

    backup := prefix + 'backup::' + filename;

		super := prefix + cleanName; 

    sub := prefix + filename + '_' + workunit;

    RETURN  STD.File.PromoteSuperFileList(
            [super, backup],
            sub,
            true
    );
END;