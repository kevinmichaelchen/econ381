cap log close
cd "~/Desktop/econ381"
*http://repec.org/bocode/e/estout/esttab.html#esttab012
ssc install estout, replace
cap use "datasets/health_status.dta"
log using "health_status/regress_health_status.log", text replace

* forced coexistence: mountain region or pacific region
cap drop region_pm
gen region_pm = region_m | region_p

* Combine poor and nearpoor; make it binary to reduce # of regressions
replace income_poor = income_poor | income_nearpoor

* interaction terms
cap drop forced_poor
cap drop forced_nearpoor
cap drop forced_nonpoor
gen forced_poor_pm = region_pm * income_poor
gen forced_poor_p  = region_p * income_poor

* Effect of Poor Income on Health Status in the Pacific and Mountain regions
eststo clear
eststo: reg percent_excellent	region_pm income_poor forced_poor_pm
eststo: reg percent_good 		region_pm income_poor forced_poor_pm
eststo: reg percent_fair 		region_pm income_poor forced_poor_pm
eststo: reg percent_excellent	region_p	income_poor forced_poor_p
eststo: reg percent_good 		region_p 	income_poor forced_poor_p
eststo: reg percent_fair 		region_p 	income_poor forced_poor_p
esttab using poorfc.tex, label nostar replace booktabs ///
title(Effect of Poor Income and Forced Coexistence on Health Statuses\label{poorfc})

* Effect of FCE on health statuses in P/M regions
eststo clear
eststo: reg percent_excellent region_pm
eststo: reg percent_good region_pm
eststo: reg percent_good region_pm
esttab using statuspm.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (Pacific and Mountain) on Health Statuses\label{statuspm})

* Effect of FCE on health statuses in P region
eststo clear
eststo: reg percent_excellent region_p
eststo: reg percent_good region_p
eststo: reg percent_good region_p
esttab using statusp.tex, label nostar replace booktabs ///
title(Effect of Forced Coexistence (Pacific) on Health Statuses\label{statusp})


log close
