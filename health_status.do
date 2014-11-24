cap log close
cd "~/Desktop/econ381"
cap use "datasets/health_status.dta"
log using "health_status.log", text replace


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* there are fewer Native Americans in the Northeast
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
count if region_ne & !missing(percent)
count if region_mw & !missing(percent)



* as expected, being poor leads to higher incidence
reg percent income_poor if status_fair & region_ne

* as expected, being nonpoor leads to lower incidence
reg percent income_nonpoor if status_fair & region_ne



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* Look at the sick and poor by region...
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
cap drop sick_and_poor
gen sick_and_poor = .
* 1 obs
replace sick_and_poor = 1 if !missing(percent) & status_fair & income_poor & region_ne
* 10 obs
replace sick_and_poor = 2 if !missing(percent) & status_fair & income_poor & region_mw
* 24 obs
replace sick_and_poor = 3 if !missing(percent) & status_fair & income_poor & region_s
* 18 obs
replace sick_and_poor = 4 if !missing(percent) & status_fair & income_poor & region_m
* 26
replace sick_and_poor = 5 if !missing(percent) & status_fair & income_poor & region_p

cap label drop sick_and_poor_group
label define sick_and_poor_group 1 "Northeast" 2 "Midwest" 3 "South" 4 "Mountain" 5 "Pacific"
label values sick_and_poor sick_and_poor_group
*graph bar percent, over(sick_and_poor) asyvars ytitle("Percent") title("Which Region has the Most Sick and Poor?")
*graph export sick_and_poor_by_region.png



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* Look at health over income
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
cap drop fair_health
cap drop good_health
cap drop excellent_health
gen fair_health = status_fair if !missing(percent)
gen good_health = status_good if !missing(percent)
gen excellent_health = status_excellent if !missing(percent)
label var fair_health "Fair/poor health"
label var good_health "Good health"
label var excellent_health "Excellent health"
*graph bar fair_health good_health excellent_health, over(income) legend(cols(3) label(1 "Fair Health") label(2 "Good Health") label(3 "Excellent Health")) nolabel asyvars stack showyvars blabel(bar, color(white) position(inside)) title("Self-reported health by income") ytitle("Percentage of total self-reports")
*graph export health_status_by_income.png

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* Look at health over region
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*graph bar fair_health good_health excellent_health, over(region) legend(cols(3) label(1 "Fair Health") label(2 "Good Health") label(3 "Excellent Health")) nolabel asyvars stack showyvars blabel(bar, color(white) position(inside)) title("Health by region") ytitle("Percentage of total self-reports")
*graph export health_status_by_region.png



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* Look at health over region and income
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
ssc install spineplot
spineplot region income


log close
