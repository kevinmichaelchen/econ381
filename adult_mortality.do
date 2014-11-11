cap log close
cd "~/Desktop/econ381"
log using "adult_mortality.log", text replace

numlabel, add
tab years
tab cause

gen all_causes    = cause == 1
gen cancer        = cause == 2
gen diabetes      = cause == 3
gen cardio        = cause == 4
gen heart_disease = cause == 5
gen ischemic      = cause == 6
gen heart_attack  = cause == 7
gen stroke        = cause == 8
gen respiratory   = cause == 9
gen cirrhosis     = cause == 10

log close
