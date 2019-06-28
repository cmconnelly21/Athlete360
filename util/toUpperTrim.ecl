IMPORT STD;
EXPORT toUpperTrim(string text) := FUNCTION

RETURN TRIM(std.str.toUppercase(text), LEFT, RIGHT);

END;