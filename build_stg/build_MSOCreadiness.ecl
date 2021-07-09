IMPORT Athlete360, STD;

// First_step get the spray file from files_spray
sprayFile := Athlete360.files_spray.MSOCreadinessfile;

// get the layout (processed layout)
stgLayout := Athlete360.Layouts.MSOCreadiness_stg;

// do all preprocessing actions and get the cleaned data from spray
stgLayout extractdata (Athlete360.Layouts.MSOCreadiness L):= transform
									SELF.Date := STD.date.FromStringToDate(L.Date,'%m/%d/%Y');
									// SELF.date := (unsigned4)L.date;
									SELF.Time := IF(std.str.splitwords(L.Time, ' ')[2]='PM',
									1200 + STD.date.FromStringToTime(L.Time,'%H:%M'),
									STD.date.FromStringToTime(L.Time,'%H:%M'));
									// SELF.time := (unsigned4)L.time;
                  self.Name := L.Firstname + ' ' + L.Lastname;
									Self.name := L.name;
									self.Score := (DECIMAL5_2)L.Score;
									self.Fatigue := (Unsigned1)L.Fatigue;
									self.Mood := (Unsigned1)L.Mood;
									self.Soreness := (Unsigned1)L.Soreness;
									self.Stress := (Unsigned1)L.Stress;
									self.SleepQuality := (Unsigned1)L.SleepQuality;
									self.SleepHours := (unsigned1)L.SleepHours;
									self.daynum := 0;
									SELF.wuid := workunit;
																								
END;																					 
	 
	 cleanedSprayFile := PROJECT(sprayFile, extractdata(LEFT));

// after we get the cleaned spray, add wtih currently staged file, dedup by unique fields

finalStageData := DEDUP(
        SORT(
            cleanedSprayFile + Athlete360.files_stg.MSOCreadiness_stgfile,
            NAME, DATE, TIME, -wuid),
        NAME, DATE, TIME
    );

mapfile := Athlete360.files_stg.athleteinfo_stgfile;

//now we link the stagedata with the athleteid related to the names from the athleteinfo file
completestgdata := join(finalStageData(time <> 0),

Athlete360.files_stg.Athleteinfo_stgfile,

Athlete360.util.toUpperTrim(left.name) = Athlete360.util.toUpperTrim(right.name),

transform({RECORDOF(LEFT)}, SELF.Athleteid := (UNSIGNED3)RIGHT.athleteid; SELF := LEFT;),

left outer

);


addmissingdates := JOIN(ATHLETE360.files_stg.MSOCdate_stgfile, DEDUP(SORT(completestgdata, name), name), true, ALL);

PlaceEmptysOncompletedatas := JOIN
    (
        completestgdata(name <> ' '), 
        addmissingdates(date <> 0), 
        LEFT.name = RIGHT.name AND
				LEFT.date = RIGHT.date,
        TRANSFORM({RECORDOF(LEFT)},
									self.daynum := Right.daynum;
									SELF.date := IF(LEFT.date <> 0, LEFT.date, RIGHT.date);
									SELF.time := IF(LEFT.time <> 0, LEFT.time, RIGHT.time);
                  self.Name := IF(LEFT.Name <> ' ', LEFT.Name, RIGHT.Name);
									self.Fatigue := IF(right.date <> 0 and left.date = 0, 0, LEFT.Fatigue);
									self.Soreness := IF(right.date <> 0 and left.date = 0, 0, LEFT.Soreness);
									self.SleepQuality := IF(right.date <> 0 and left.date = 0, 0, LEFT.SleepQuality);
									self.Stress := IF(right.date <> 0 and left.date = 0, 0, LEFT.Stress);
									self.mood := IF(right.date <> 0 and left.date = 0, 0, LEFT.mood);
									SELF.SleepHours := IF(right.date <> 0 and left.date = 0, 0, LEFT.SleepHours);
									self.Score := IF(right.date <> 0 and left.date = 0, 0, LEFT.Score);
									SELF.Athleteid := IF(LEFT.Athleteid <> 0, LEFT.Athleteid, RIGHT.Athleteid);
									SELF.wuid := workunit;
            // SELF.sessionoverall := IF(LEFT.sessionoverall <> 0, LEFT.sessionoverall, RIGHT.sessionoverall);
        ),
        Full Outer
    );
		

completetestdata_sorted := SORT(
        project(PlaceEmptysOncompletedatas(name <> ''), transform({recordof(completestgdata), decimal5_2 old_score}, self := left; self := [])),
        name, date, time);	

replacePreviousOnEmptycompletedatas := ITERATE(
        completetestdata_sorted,
		transform({recordof(completestgdata), decimal5_2 old_score},
			self.score := if(counter = 1 or left.name != right.name, right.score, if(right.score = 0 and left.name = right.name, left.score, right.score));// if(counter = 1 or (left.score = 0 and left.name = right.name), right.score, left.score);
            self.old_score := right.score;
			// self.name := if(counter = 1, right.name, left.name);
			self := right;//if(left.name = '' , right, left);
		)
);

temp1 := RECORD
		UNSIGNED4 Date;
		UNSIGNED3 Time;
		unsigned3 daynum;
		STRING Name;
		DECIMAL5_2 Score;
		UNSIGNED1 Fatigue;
		UNSIGNED1 Mood;
		UNSIGNED1 Soreness;
		UNSIGNED1 Stress;
		UNSIGNED1 Sleepquality;
		UNSIGNED1 Sleephours;
		string19 wuid := workunit;
		UNSIGNED3 athleteid;
	END;
	
// Finalresult1 := project(replacePreviousOnEmptycompletedatas,Transform({RECORDOF(temp1)},self.athleteid := (Integer)left.athleteid;self := Left));


Finalresult2 := join(replacePreviousOnEmptycompletedatas, 
											Athlete360.files_stg.MSOCgps_stgfile, 
											left.name = right.name AND
											left.date = right.date,
											Transform({RECORDOF(temp1), UNSIGNED1 week, UNSIGNED1 year},
																	self.week := right.week,
																	self.year := IF(left.date > 20180000 AND left.date < 20190000, 1, IF(left.date > 20190000 AND left.date < 20200000, 2, IF(left.date > 20200000 AND left.date < 20210000, 3, 4))),
																	self := left),
																	left outer);

// OUTPUT(cleanedsprayfile[1..5000]);		
// OUTPUT(completestgdata(date > 20190812)[1..5000]);
// OUTPUT(sort(addmissingdates(date<>0),name,date)[1..5000]);
// OUTPUT(PlaceEmptysOncompletedatas[1..5000]);
// OUTPUT(completetestdata_sorted[1..5000]);
// OUTPUT(replacePreviousOnEmptycompletedatas[1..5000]);
// OUTPUT(finalresult1[1..5000]);
// OUTPUT(finalresult2[1..5000]);

// by above, you will have concatenated set consists of prevoius data and new spray data, making sure no duplicates created.
// promote  the final dataset into stage gile
EXPORT build_MSOCreadiness := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCreadiness_name, finalresult2);