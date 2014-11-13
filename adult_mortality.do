cap log close
cd "~/Desktop/econ381"
log using "adult_mortality.log", text replace

numlabel, add
tab years
tab cause

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

log close
