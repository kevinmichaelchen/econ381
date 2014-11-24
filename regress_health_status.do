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

* Effect of Poor Income on Health Status in the Pacific and Mountain regions
eststo clear
eststo: reg percent_excellent forced_coex income_poor forced_poor
eststo: reg percent_good forced_coex income_poor forced_poor
eststo: reg percent_fair forced_coex income_poor forced_poor
esttab using p_m_poor.tex, label nostar replace booktabs ///
title(Effect of Poor Income on Health Statues in the Pacific and Mountain Regions\label{p_m_poor})

* Effect of Near-Poor Income on Health Status in the Pacific and Mountain regions
eststo clear
eststo: reg percent_excellent forced_coex income_nearpoor forced_nearpoor
eststo: reg percent_good forced_coex income_nearpoor forced_nearpoor
eststo: reg percent_fair forced_coex income_nearpoor forced_nearpoor
esttab using p_m_nearpoor.tex, label nostar replace booktabs ///
title(Effect of Near-Poor Income on Health Statues in the Pacific and Mountain Regions\label{p_m_nearpoor})

* Effect of Non-Poor Income on Health Status in the Pacific and Mountain regions
eststo clear
eststo: reg percent_excellent forced_coex income_nonpoor forced_nonpoor
eststo: reg percent_good forced_coex income_nonpoor forced_nonpoor
eststo: reg percent_fair forced_coex income_nonpoor forced_nonpoor
esttab using p_m_nonpoor.tex, label nostar replace booktabs ///
title(Effect of Non-Poor Income on Health Statues in the Pacific and Mountain Regions\label{p_m_nearpoor})



* Effect of Poor Income on Health Status in the Pacific region
eststo clear
eststo: reg percent_excellent region_p income_poor forced_poor
eststo: reg percent_good region_p income_poor forced_poor
eststo: reg percent_fair region_p income_poor forced_poor
esttab using p_poor.tex, label nostar replace booktabs ///
title(Effect of Poor Income on Health Statues in the Pacific Regions\label{p_poor})

* Effect of Near-Poor Income on Health Status in the Pacific region
eststo clear
eststo: reg percent_excellent region_p income_nearpoor forced_nearpoor
eststo: reg percent_good region_p income_nearpoor forced_nearpoor
eststo: reg percent_fair region_p income_nearpoor forced_nearpoor
esttab using p_nearpoor.tex, label nostar replace booktabs ///
title(Effect of Poor Income on Health Statues in the Pacific Region\label{p_nearpoor})

* Effect of Non-Poor Income on Health Status in the Pacific region
eststo clear
eststo: reg percent_excellent region_p income_nonpoor forced_nonpoor
eststo: reg percent_good region_p income_nonpoor forced_nonpoor
eststo: reg percent_fair region_p income_nonpoor forced_nonpoor
esttab using p_nonpoor.tex, label nostar replace booktabs ///
title(Effect of Poor Income on Health Statues in the Pacific Region\label{p_nonpoor})



log close
