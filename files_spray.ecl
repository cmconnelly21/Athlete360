EXPORT files_spray := MODULE

IMPORT Athlete360;

    EXPORT WSOCdatefile := DATASET( Athlete360.util.constants.spray_prefix + 'WSOC_dates',Layout,CSV(HEADING(1)), OPT);

END;
