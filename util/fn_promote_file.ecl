EXPORT fn_promote_file(string prefix, String filename) := FUNCTION

    import STD;

    backup := prefix + 'backup::' + filename;

    super := prefix +  IF(STD.str.Find(filename, 'session overall_rawdata') > 0, IF(std.str.Find(filename, 'women') > 0, 'ws_rawgps', 'ms_rawgps'), filename);

    sub := prefix + filename + '_' + workunit;

    RETURN  STD.File.PromoteSuperFileList(
            [super, backup],
            sub,
            true
    );
END;