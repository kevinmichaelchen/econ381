cap log close
cd "~/Desktop/econ381"
ssc install estout, replace
cap use "datasets/adult_mortality_per_hundred_thousand.dta"
log using "adult_mortality/adult_mortality.log", text replace

numlabel, add
tab years
tab cause

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
eststo: reg all_causes forced_coex
eststo: reg cancer forced_coex 
eststo: reg diabetes forced_coex 
eststo: reg heart_disease forced_coex 
eststo: reg respiratory forced_coex 
eststo: reg cirrhosis forced_coex 
esttab using adult1.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA) on Adult Mortality\label{adult1})

** MODEL 2
replace forced_coex = state=="California" | state=="Washington"
eststo clear
eststo: reg all_causes forced_coex
eststo: reg cancer forced_coex 
eststo: reg diabetes forced_coex 
eststo: reg heart_disease forced_coex 
eststo: reg respiratory forced_coex 
eststo: reg cirrhosis forced_coex 
esttab using adult2.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA, WA) on Adult Mortality\label{adult2})

** MODEL 3
replace forced_coex = state=="California" | state=="Washington" | state=="Arizona" | state=="Utah"
eststo clear
eststo: reg all_causes forced_coex
eststo: reg cancer forced_coex 
eststo: reg diabetes forced_coex 
eststo: reg heart_disease forced_coex 
eststo: reg respiratory forced_coex 
eststo: reg cirrhosis forced_coex 
esttab using adult3.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA, WA, AZ, UT) on Adult Mortality\label{adult3})

** MODEL 4
replace forced_coex = state=="California" | state=="Washington" | state=="Montana" | state=="Arizona" | state=="Idaho" | state=="Utah"
eststo clear
eststo: reg all_causes forced_coex
eststo: reg cancer forced_coex 
eststo: reg diabetes forced_coex 
eststo: reg heart_disease forced_coex 
eststo: reg respiratory forced_coex 
eststo: reg cirrhosis forced_coex 
esttab using adult4.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (CA, WA, MT, AZ, ID, UT) on Adult Mortality\label{adult4})



* GRAPH MORTALITY OVER STATE
graph bar cancer diabetes cardio heart_disease ischemic heart_attack stroke respiratory cirrhosis, over(state) nolabel asyvars stack showyvars title("Mortality by state") ytitle("Per hundred thousand mortality")
*graph export mortality_by_state.png


log close
