cap log close
cd "~/Desktop/econ381"
cap use "datasets/health_status.dta"
log using "regress_health_status.log", text replace

* forced coexistence: mountain region or pacific region
cap drop forced_coex
gen forced_coex = region_m | region_p

* interaction terms
cap drop forced_poor
cap drop forced_nearpoor
cap drop forced_nonpoor
gen forced_poor     = forced_coex * income_poor
gen forced_nearpoor = forced_coex * income_nearpoor
gen forced_nonpoor  = forced_coex * income_nonpoor

* predict the percentage of self-reported "excellent"s 
* based on income and whether region had forced coexistence
reg percent_excellent forced_coex income_poor forced_poor
reg percent_good forced_coex income_poor forced_poor
reg percent_fair forced_coex income_poor forced_poor


reg percent_excellent region_p income_poor forced_poor
reg percent_good region_p income_poor forced_poor
reg percent_fair region_p income_poor forced_poor

log close
