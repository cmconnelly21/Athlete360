IMPORT $;

sortRec := SORT($.WSOClr.File(Name='Kia Rankin'OR Name ='Anna Toohey'),Name,Date);

OUTPUT(sortRec);