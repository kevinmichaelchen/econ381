cap log close
cd "~/Desktop/econ381"
ssc install estout, replace
ssc install sutex, replace
cap use "datasets/adult_mortality_per_hundred_thousand.dta"
log using "adult_mortality/adult_mortality.log", text replace

numlabel, add
tab years
tab cause

cap drop state_abbrev
gen str20 state_abbrev = ""
replace state_abbrev = "AL" if state=="Alabama"
replace state_abbrev = "AK" if state=="Alaska"
replace state_abbrev = "AZ" if state=="Arizona"
replace state_abbrev = "AR" if state=="Arkansas"
replace state_abbrev = "CA" if state=="California"
replace state_abbrev = "CO" if state=="Colorado"
replace state_abbrev = "CT" if state=="Connecticut"
replace state_abbrev = "DE" if state=="Delaware"
*replace state_abbrev = "" if state=="District of Columbia"
replace state_abbrev = "FL" if state=="Florida"
replace state_abbrev = "GA" if state=="Georgia"
replace state_abbrev = "HI" if state=="Hawaii"
replace state_abbrev = "ID" if state=="Idaho"
replace state_abbrev = "IL" if state=="Illinois"
replace state_abbrev = "IN" if state=="Indiana"
replace state_abbrev = "IA" if state=="Iowa"
replace state_abbrev = "KS" if state=="Kansas"
replace state_abbrev = "KY" if state=="Kentucky"
replace state_abbrev = "LA" if state=="Louisiana"
replace state_abbrev = "ME" if state=="Maine"
replace state_abbrev = "MD" if state=="Maryland"
replace state_abbrev = "MA" if state=="Massachusetts"
replace state_abbrev = "MI" if state=="Michigan"
replace state_abbrev = "MN" if state=="Minnesota"
replace state_abbrev = "MS" if state=="Mississippi"
replace state_abbrev = "MO" if state=="Missouri"
replace state_abbrev = "MT" if state=="Montana"
replace state_abbrev = "NE" if state=="Nebraska"
replace state_abbrev = "NV" if state=="Nevada"
replace state_abbrev = "NH" if state=="New Hampshire"
replace state_abbrev = "NJ" if state=="New Jersey"
replace state_abbrev = "NM" if state=="New Mexico"
replace state_abbrev = "NY" if state=="New York"
replace state_abbrev = "NC" if state=="North Carolina"
replace state_abbrev = "ND" if state=="North Dakota"
replace state_abbrev = "OH" if state=="Ohio"
replace state_abbrev = "OK" if state=="Oklahoma"
replace state_abbrev = "OR" if state=="Oregon"
replace state_abbrev = "PA" if state=="Pennsylvania"
replace state_abbrev = "RI" if state=="Rhode Island"
replace state_abbrev = "SC" if state=="South Carolina"
replace state_abbrev = "SD" if state=="South Dakota"
replace state_abbrev = "TN" if state=="Tennessee"
replace state_abbrev = "TX" if state=="Texas"
*replace state_abbrev = "" if state=="U.S."
replace state_abbrev = "UT" if state=="Utah"
replace state_abbrev = "VT" if state=="Vermont"
replace state_abbrev = "VA" if state=="Virginia"
replace state_abbrev = "WA" if state=="Washington"
replace state_abbrev = "WV" if state=="West Virginia"
replace state_abbrev = "WI" if state=="Wisconsin"
replace state_abbrev = "WY" if state=="Wyoming"

drop if state=="U.S."

cap drop all_causes
cap drop cancer
cap drop diabetes
cap drop cardio
cap drop heart_disease
cap drop ischemic
cap drop heart_attack
cap drop stroke
cap drop respiratory
cap drop cirrhosis
cap drop chronic

gen all_causes    = mortality if cause == 1  /* sufficient n */
gen cancer        = mortality if cause == 2  /* sufficient n */
gen diabetes      = mortality if cause == 3
gen cardio        = mortality if cause == 4  /* sufficient n */
gen heart_disease = mortality if cause == 5  /* sufficient n */
gen ischemic      = mortality if cause == 6  /* sufficient n */
gen heart_attack  = mortality if cause == 7
gen stroke        = mortality if cause == 8
gen respiratory   = mortality if cause == 9
gen cirrhosis     = mortality if cause == 10
gen chronic       = mortality if cancer | diabetes | cardio | ///
                                 heart_disease | ischemic | cirrhosis


sum all_causes cancer diabetes cardio heart_disease ischemic heart_attack stroke respiratory cirrhosis
sutex

count if cause == 1 & !missing(mortality)
count if cause == 2 & !missing(mortality)
count if cause == 3 & !missing(mortality)
count if cause == 4 & !missing(mortality)
count if cause == 5 & !missing(mortality)
count if cause == 6 & !missing(mortality)
count if cause == 7 & !missing(mortality)
count if cause == 8 & !missing(mortality)
count if cause == 9 & !missing(mortality)
count if cause == 10 & !missing(mortality)

cap drop forced_coex

** MODEL 1
gen forced_coex = state=="California"
reg cardio forced_coex
reg ischemic forced_coex
reg heart_attack forced_coex
reg stroke forced_coex

eststo clear
eststo: quietly reg all_causes forced_coex
eststo: quietly reg cancer forced_coex 
eststo: quietly reg diabetes forced_coex 
eststo: quietly reg heart_disease forced_coex 
eststo: quietly reg respiratory forced_coex 
eststo: quietly reg cirrhosis forced_coex 
esttab using adult1.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA) on Adult Mortality\label{adult1})

** MODEL 2
replace forced_coex = state=="California" | state=="Washington"
eststo clear
eststo: quietly reg all_causes forced_coex
eststo: quietly reg cancer forced_coex 
eststo: quietly reg diabetes forced_coex 
eststo: quietly reg heart_disease forced_coex 
eststo: quietly reg respiratory forced_coex 
eststo: quietly reg cirrhosis forced_coex 
esttab using adult2.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA, WA) on Adult Mortality\label{adult2})

** MODEL 3
replace forced_coex = 	state=="California" | state=="Washington" | ///
						state=="Arizona" 	| state=="Utah"
eststo clear
eststo: quietly reg all_causes forced_coex
eststo: quietly reg cancer forced_coex 
eststo: quietly reg diabetes forced_coex 
eststo: quietly reg heart_disease forced_coex 
eststo: quietly reg respiratory forced_coex 
eststo: quietly reg cirrhosis forced_coex 
esttab using adult3.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA, WA, AZ, UT) on Adult Mortality\label{adult3})

** MODEL 4
replace forced_coex = 	state=="California" | state=="Washington" 	| ///
						state=="Arizona" 	| state=="Utah" 		| ///
						state=="Idaho" 		| state=="Montana"
eststo clear
eststo: quietly reg all_causes forced_coex
eststo: quietly reg cancer forced_coex 
eststo: quietly reg diabetes forced_coex 
eststo: quietly reg heart_disease forced_coex 
eststo: quietly reg respiratory forced_coex 
eststo: quietly reg cirrhosis forced_coex 
esttab using adult4.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA, WA, MT, AZ, ID, UT) on Adult Mortality\label{adult4})


cap drop f1
cap drop f2
cap drop f3
cap drop f4

gen f1 = 	state=="California"
reg chronic f1

gen f2 = 	state=="California" | state=="Washington"
reg chronic f2

gen f3 = 	state=="California" | state=="Washington" | ///
			state=="Arizona" 	| state=="Utah"
reg chronic f3

log close
