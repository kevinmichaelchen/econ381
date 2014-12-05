cap log close
cd "~/Desktop/econ381"
*http://repec.org/bocode/e/estout/esttab.html#esttab012
ssc install estout, replace
cap use "datasets/health_status.dta"
log using "health_status/regress_health_status.log", text replace

* forced coexistence: mountain region or pacific region
cap drop forced_coex
gen forced_coex = region_m | region_p

* Combine poor and nearpoor; make it binary to reduce # of regressions
replace income_poor = income_poor | income_nearpoor

* interaction terms
cap drop forced_poor
cap drop forced_nearpoor
cap drop forced_nonpoor
gen forced_poor     = forced_coex * income_poor
gen forced_nonpoor  = forced_coex * income_nonpoor

* Effect of Poor Income on Health Status in the Pacific and Mountain regions
eststo clear
eststo: reg percent_excellent forced_coex income_poor forced_poor
eststo: reg percent_good forced_coex income_poor forced_poor
eststo: reg percent_fair forced_coex income_poor forced_poor
esttab using p_m_poor.tex, label nostar replace booktabs ///
title(Effect of Poor Income on Health Statuses in the Pacific and Mountain Regions\label{pmpoor})

* Effect of Poor Income on Health Status in the Pacific region
eststo clear
eststo: reg percent_excellent region_p income_poor forced_poor
eststo: reg percent_good region_p income_poor forced_poor
eststo: reg percent_fair region_p income_poor forced_poor
esttab using p_poor.tex, label nostar replace booktabs ///
title(Effect of Poor Income on Health Statuses in the Pacific Region\label{ppoor})

* Effect of FCE on health statuses in P/M regions
eststo clear
eststo: reg percent_excellent forced_coex
eststo: reg percent_good forced_coex
eststo: reg percent_good forced_coex
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
