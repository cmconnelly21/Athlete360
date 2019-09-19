IMPORT Std;

EXPORT DateAddendum := MODULE

    /**
     * Helper function.  Calculates the 1-based week number of a date, starting from
     * a reference date.  Week 1 always contains the reference date, and week 2
     * begins on the following day of the week indicated by the value of
     * startingDayOfWeek.  This is not an ISO-8601 implementation of computing week
     * numbers ("week dates").
     *
     * @param date              The date for which to compute the week number;
     *                          must be greater than or equal to referenceDate
     * @param referenceDate     The date from which the week number counting begins;
     *                          must be less than or equal to date
     * @param startingDayOfWeek The index number of the first day of a week, 1-7,
     *                          where 1 = Sunday
     * @return                  The 1-based week number of date, relative to
     *                          referenceDate
     *
     * @see YearWeekNumFromDate, MonthWeekNumFromDate
     */

    SHARED WeekNumForDate(Std.Date.Date_t date, Std.Date.Date_t referenceDate, UNSIGNED1 startingDayOfWeek) := FUNCTION
        referenceDayOfWeek := Std.Date.DayOfWeek(referenceDate);
        startingDayOfWeekDelta := (startingDayOfWeek - referenceDayOfWeek) % 7;
        referenceFirstDateOfWeek := Std.Date.AdjustDate(referenceDate, day_delta := startingDayOfWeekDelta);
        numberOfDays := Std.Date.DaysBetween(referenceFirstDateOfWeek, date) + 1;
        weekNum0 := (numberOfDays + 6) DIV 7;
        weekNum := IF(startingDayOfWeek > referenceDayOfWeek, weekNum0 + 1, weekNum0);

        RETURN weekNum;
    END;

    /**
     * Returns a number representing the day of the week indicated by the given date in ISO-8601.
     * The date must be in the Gregorian calendar after the year 1600.
     *
     * @param date          A Std.Date.Date_t value.
     * @return              A number 1-7 representing the day of the week, where 1 = Monday.
     */
    EXPORT ISODayOfWeekFromDate(Std.Date.Date_t d) := ((Std.Date.DayOfWeek(d) + 5) % 7) + 1;

    /**
     * Helper function to figure out the number of weeks for a given year.
     * For more details, see: https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
     *
     * @param date          A Std.Date.Date_t value.
     * @return              Number between 0 and 6 to help figure out whether year is long (53 weeks) or short (52 weeks).
     */
    SHARED ISOWeeksP(INTEGER2 year) := (year + TRUNCATE(year/4) - TRUNCATE(year/100) + TRUNCATE(year/400)) % 7;

    /**
     * Returns true for years with 53 weeks, and false for years with 52 weeks.
     *
     * @param date          A Std.Date.Date_t value.
     * @return              TRUE if year is a long year (i.e. 53 weeks), FALSE otherwise.
     */
    EXPORT ISOIsLongYear(INTEGER2 year) := (ISOWeeksP(year) = 4 OR ISOWeeksP(year - 1) = 3);

    /**
     * Returns a number representing the maximum number of weeks for the year from date.
     *
     * @param date          A Std.Date.Date_t value.
     * @return              The number 52 for short years and 53 for long ones.
     */
    EXPORT ISOWeeksFromDate(Std.Date.Date_t d) := 52 + IF(ISOIsLongYear(Std.Date.Year(d)), 1, 0);

    /**
     * Returns a number representing the raw week number of the given date.
     *
     * @param date          A Std.Date.Date_t value.
     * @return              A number from 1 to 53.
     */
    EXPORT ISORawWeekNumForDate(Std.Date.Date_t d) := TRUNCATE((Std.Date.DayOfYear(d) - ISODayOfWeekFromDate(d) + 10) / 7);

    /**
     * Returns the ISO 1-based week number and year, of that week number, of a date.
     * First day(s) of a year may be in the previous year's last week number.
     * This is an ISO-8601 implementation of computing week numbers ("week dates").
     *
     * @param date          A Std.Date.Date_t value.
     * @return              A number 1-53 representing the week number in a year,
     *                      and year 1600+ representing the year of that week number
     *                      (could be previous year from given date).
     */
    EXPORT ISOWeekNumWeekDayAndYearFromDate(Std.Date.Date_t d) := FUNCTION
        givenYear := Std.Date.Year(d);
        lastDayPreviousYear := Std.Date.DateFromParts(givenYear - 1, 12, 31);
        lastWeekPreviousYear := ISOWeeksFromDate(lastDayPreviousYear);
        lastDayGivenYear := Std.Date.DateFromParts(givenYear, 12, 31);
        lastWeekGivenYear := ISOWeeksFromDate(lastDayGivenYear);
        rawWeekNumber := ISORawWeekNumForDate(d);
        weekNumber := IF(rawWeekNumber < 1, lastWeekPreviousYear, IF(rawWeekNumber > lastWeekGivenYear, 1, rawWeekNumber));
        weekNumberYear := (givenYear + IF(rawWeekNumber < 1, -1, IF(rawWeekNumber > lastWeekGivenYear, 1, 0)));
        weekDay := ISODayOfWeekFromDate(d);
        result := MODULE
            EXPORT weekNumber := weekNumber;
            EXPORT year := weekNumberYear;
            EXPORT weekDay := weekDay;
        END;
        RETURN result;
    END;

    /**
     * Returns the ISO-8601 week date in extended (e.g. 2018-W23-7) or
     * compact (e.g. 2018W237) form.
     * This is an ISO-8601 implementation of computing week numbers ("week dates").
     *
     * @param date          A Std.Date.Date_t value.
     * @return              A number 1-53 representing the week number in a year,
     *                      and year 1600+ representing the year of that week number
     *                      (could be previous year from given date).
     */
    EXPORT ISOWeekDate(Std.Date.Date_t d, BOOLEAN extended = FALSE) := FUNCTION
        ISOWeekNumWeekDayAndYear := ISOWeekNumWeekDayAndYearFromDate(d);
        sep := IF(extended, '-', '');
        RETURN INTFORMAT(ISOWeekNumWeekDayAndYear.year, 4, 1) + sep + 'W' + INTFORMAT(ISOWeekNumWeekDayAndYear.weeknumber, 2, 1) + sep + ISOWeekNumWeekDayAndYear.weekday;
    END;

    /**
     * Returns the 1-based week number of a date within the date's year.  Week 1
     * always contains the first day of the year, and week 2 begins on the
     * following day of the week indicated by the value of startingDayOfWeek.  This
     * is not an ISO-8601 implementation of computing week numbers ("week dates").
     *
     * @param date              The date for which to compute the week number
     * @param startingDayOfWeek The index number of the first day of a week, 1-7,
     *                          where 1 = Sunday; OPTIONAL, defaults to 1
     * @return                  The 1-based week number of date, relative to
     *                          the beginning of the date's year
     *
     * @see MonthWeekNumFromDate
     */

    EXPORT YearWeekNumFromDate(Std.Date.Date_t date, UNSIGNED1 startingDayOfWeek = 1) := FUNCTION
        yearStart := Std.Date.DateFromParts(Std.Date.Year(date), 1, 1);

        RETURN WeekNumForDate(date, yearStart, startingDayOfWeek);
    END;

    /**
     * Returns the 1-based week number of a date within the date's month.  Week 1
     * always contains the first day of the month, and week 2 begins on the
     * following day of the week indicated by the value of startingDayOfWeek.  This
     * is not an ISO-8601 implementation of computing week numbers ("week dates").
     *
     * @param date              The date for which to compute the week number
     * @param startingDayOfWeek The index number of the first day of a week, 1-7,
     *                          where 1 = Sunday; OPTIONAL, defaults to 1
     * @return                  The 1-based week number of date, relative to
     *                          the beginning of the date's month
     *
     * @see YearWeekNumFromDate
     */

    EXPORT MonthWeekNumFromDate(Std.Date.Date_t date, UNSIGNED1 startingDayOfWeek = 1) := FUNCTION
        monthStart := Std.Date.DateFromParts(Std.Date.Year(date), Std.Date.Month(date), 1);

        RETURN WeekNumForDate(date, monthStart, startingDayOfWeek);
    END;

END;
