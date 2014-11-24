cap log close
cd "~/Desktop/econ381"
*http://repec.org/bocode/e/estout/esttab.html#esttab012
ssc install estout, replace
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
eststo clear
eststo: reg percent_excellent forced_coex income_poor forced_poor
eststo: reg percent_good forced_coex income_poor forced_poor
eststo: reg percent_fair forced_coex income_poor forced_poor
eststo: reg percent_excellent forced_coex income_nearpoor forced_nearpoor
eststo: reg percent_good forced_coex income_nearpoor forced_nearpoor
eststo: reg percent_fair forced_coex income_nearpoor forced_nearpoor
eststo: reg percent_excellent forced_coex income_nonpoor forced_nonpoor
eststo: reg percent_good forced_coex income_nonpoor forced_nonpoor
eststo: reg percent_fair forced_coex income_nonpoor forced_nonpoor
esttab using pacific_and_mountain.tex, label nostar replace booktabs ///
title(Pacific and Mountain\label{both})



** same thing but with region_p
eststo clear
eststo: reg percent_excellent region_p income_poor forced_poor
eststo: reg percent_good region_p income_poor forced_poor
eststo: reg percent_fair region_p income_poor forced_poor
eststo: reg percent_excellent region_p income_nearpoor forced_nearpoor
eststo: reg percent_good region_p income_nearpoor forced_nearpoor
eststo: reg percent_fair region_p income_nearpoor forced_nearpoor
eststo: reg percent_excellent region_p income_nonpoor forced_nonpoor
eststo: reg percent_good region_p income_nonpoor forced_nonpoor
eststo: reg percent_fair region_p income_nonpoor forced_nonpoor
esttab using pacific.tex, label nostar replace booktabs ///
title(Pacific\label{pacific})



log close
