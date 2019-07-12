IMPORT Athlete360, std;

rawDs := SORT(Athlete360.RawGPS.processedfile, name, ElapsedTime) : INDEPENDENT;




inputDs := PROJECT(
        rawDs,
        TRANSFORM({RECORDOF(LEFT); integer cnt; 
						decimal15_8 speedtotal := 0;
						decimal15_8 distance := 0};
            SELF.cnt := COUNTER;
						self := left;
        )
);



outputDs := ITERATE(inputDs,
    TRANSFORM({RECORDOF(LEFT)},
		self.cnt := RIGHT.cnt;
		self.speedtotal := IF(self.cnt = 1, right.speed, left.speedtotal + right.speed);
		self.distance := (left.elapsedtime * (left.speedtotal/left.cnt));
		self := right
				
				
				
    )

);
OUTPUT(inputDs, all);
output(outputDs, all);