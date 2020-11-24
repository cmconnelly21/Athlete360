IMPORT Athlete360, STD;

readinessdata := Athlete360.files_stg.MSOCreadiness_stgfile;

Layout := Athlete360.Layouts.MSOCreadinessNUM_stg;

readinessNUMdata := Project(readinessdata,transform({RECORDOF(layout), integer id},
																				SELF.Date := Left.Date;
																				SELF.Time := Left.Time;
																				SELF.DayNum := Left.daynum;
																				SELF.id := COUNTER;
																				SELF.athleteid := Left.athleteid;
																				self.Score := (DECIMAL5_2)Left.Score;
																				self.Fatigue := (Unsigned1)Left.Fatigue;
																				self.Mood := (Unsigned1)Left.Mood;
																				self.Soreness := (Unsigned1)Left.Soreness;
																				self.Stress := (Unsigned1)Left.Stress;
																				self.SleepQuality := (Unsigned1)Left.SleepQuality;
																				self.SleepHours := (unsigned1)Left.SleepHours;
																				SELF.wuid := workunit;
																				)
																				);
																				



// OUTPUT(readinessNUMdata);
EXPORT build_MSOCreadinessNUM := Athlete360.util.fn_promote_ds(Athlete360.util.constants.stg_prefix,  Athlete360.util.constants.MSOCreadinessNUM_name, readinessNUMdata);