EXPORT files_spray := MODULE

IMPORT Athlete360;

    EXPORT WSOCdatefile := DATASET( Athlete360.util.constants.spray_prefix + 'athlete360_ws_dates.csv', Athlete360.Layouts.WSOCdatefile, CSV(HEADING(1)), OPT);

END;
