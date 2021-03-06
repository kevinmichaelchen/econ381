clear
cap log close
cd "~/Desktop/econ381"
log using "reshape/reshape_adult_mortality.log", text replace
insheet using "adult_mortality2.csv", comma

* c<cause>_y<year>

* years: 0002, 0305, 0608, 0911
reshape long c1_y c2_y c3_y c4_y c5_y c6_y c7_y c8_y c9_y c10_y c11_y c12_y, i(state) j(years)
label define yearslabel 1 "2000-2002" 2 "2003-2005" 3 "2006-2008" 4 "2009-2011"
label values years yearslabel
rename *_y *

* causes: all, cancer, diabetes, cardiovascular disease, heart disease, ischemic heart disease, heart attack, stroke, chronic lower respiratory, chronic liver disease and cirrhosis
reshape long c, i(state years) j(cause)
label define causelabel 1 "all" 2 "cancer" 3 "diabetes" ///
						4 "cardiovascular disease" 5 "heart disease" ///
						6 "ischemic heart disease" 7 "heart attack" ///
						8 "stroke" 9 "chronic lower respirator" ///
						10 "chronic liver disease and cirrhosis" ///
						11 "chronic" 12 "nonchronic"
label values cause causelabel
rename c mortality
label var mortality "Adult Mortality Per Hundred Thousand"

replace mortality = . if mortality == 999

log close
