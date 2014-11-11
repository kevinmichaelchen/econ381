cap log close
cd "~/Desktop/econ381"
log using "adult_mortality.log", text replace

numlabel, add
tab years
tab cause

gen all_causes    = cause == 1  /* sufficient n */
gen cancer        = cause == 2  /* sufficient n */
gen diabetes      = cause == 3
gen cardio        = cause == 4  /* sufficient n */
gen heart_disease = cause == 5  /* sufficient n */
gen ischemic      = cause == 6  /* sufficient n */
gen heart_attack  = cause == 7
gen stroke        = cause == 8
gen respiratory   = cause == 9
gen cirrhosis     = cause == 10

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
