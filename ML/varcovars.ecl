IMPORT Athlete360, STD, ML_Core, LinearRegression;


gpsdata := Athlete360.files_stg.MSOCgpsNUM_stgfile(drillname = 116);
subdata := Athlete360.files_stg.MSOCreadinessNUM_stgfile;


temp1 := RECORD
UNSIGNED4 id;
UNSIGNED4 athid;
UNSIGNED1 FOR;
UNSIGNED1 CM;
UNSIGNED1 CAM;
UNSIGNED1 CDM;
UNSIGNED1 WM;
UNSIGNED1 FB;
UNSIGNED1 OB;
UNSIGNED1 GK;
UNSIGNED1 Session1;
UNSIGNED1 Session2;
UNSIGNED1 week;
UNSIGNED3 DayNum;
UNSIGNED3 drillname;
DECIMAL10_5 drilldistance;
DECIMAL5_2 distancepermin;
DECIMAL5_2 highspeeddistance;
DECIMAL5_2 AverageHR;
DECIMAL5_2 Timeabove85;
DECIMAL5_2 sprints;
DECIMAL5_2 dynamicstressloadtotal;
DECIMAL5_2 HSRpermin;
DECIMAL5_2 impacts;
DECIMAL5_2 Drilltotaltime;
END;


//join datasets
fulldata := join
    (
        gpsdata,
        subdata,
        left.athid = right.athleteid AND 
	        Left.DayNum = Right.DayNum+1,
        transform
            ({RECORDOF(temp1), unsigned1 score, unsigned1 fatigue, unsigned1 mood, unsigned1 soreness, 
															unsigned1 stress, unsigned1 sleepquality, unsigned1 sleephours, unsigned4 time},
                SELF.score := right.score;
								SELF.fatigue := right.fatigue;
								SELF.mood := right.mood;
								SELF.soreness := right.soreness;
								SELF.stress := right.stress;
								SELF.sleepquality := right.sleepquality;
								SELF.sleephours := right.sleephours;
                SELF.DayNum := Left.DayNum,
								SELF.time := right.time;
                SELF := LEFT
            ),
						LOOKUP
    );


// Extended data format


mydataExt := project(fulldata,Transform({RECORDOF(LEFT), UNSIGNED4 rnd := 0},self := Left)); // A random number


// Assign a random number to each record
myDataE := PROJECT(fulldata, TRANSFORM({RECORDOF(mydataExt)}, SELF.rnd := RANDOM(), SELF := LEFT));


var1 := COVARIANCE(MyDataE,Drilldistance,Timeabove85);
cor1 := CORRELATION(MyDataE,Drilldistance,Timeabove85);
var2 := COVARIANCE(MyDataE,Drilldistance,Distancepermin);
cor2 := CORRELATION(MyDataE,Drilldistance,Distancepermin);
var3 := COVARIANCE(MyDataE,Drilldistance,HSRpermin);
cor3 := CORRELATION(MyDataE,Drilldistance,HSRpermin);
var4 := COVARIANCE(MyDataE,Distancepermin,Timeabove85);
cor4 := CORRELATION(MyDataE,Distancepermin,Timeabove85);
var5 := COVARIANCE(MyDataE,Distancepermin,HSRpermin);
cor5 := CORRELATION(MyDataE,Distancepermin,HSRpermin);
var6 := COVARIANCE(MyDataE,Timeabove85,HSRpermin);
cor6 := CORRELATION(MyDataE,Timeabove85,HSRpermin);

OUTPUT(var1);
OUTPUT(cor1);
OUTPUT(var2);
OUTPUT(cor2);
OUTPUT(var3);
OUTPUT(cor3);
OUTPUT(var4);
OUTPUT(cor4);
OUTPUT(var5);
OUTPUT(cor5);
OUTPUT(var6);
OUTPUT(cor6);