cap log close
cd "~/Desktop/econ381"
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
graph bar percent, over(sick_and_poor) asyvars ytitle("Percent") title("Which Region has the Most Sick and Poor?")



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* Look at health over income
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
cap drop health_by_income
gen health_by_income = .
replace health_by_income = 1 if !missing(percent) & income_nonpoor & status_fair
replace health_by_income = 2 if !missing(percent) & income_nonpoor & status_good
replace health_by_income = 3 if !missing(percent) & income_nonpoor & status_excellent

replace health_by_income = 4 if !missing(percent) & income_nearpoor & status_fair
replace health_by_income = 5 if !missing(percent) & income_nearpoor & status_good
replace health_by_income = 6 if !missing(percent) & income_nearpoor & status_excellent

replace health_by_income = 7 if !missing(percent) & income_poor & status_fair
replace health_by_income = 8 if !missing(percent) & income_poor & status_good
replace health_by_income = 9 if !missing(percent) & income_poor & status_excellent

cap label drop health_by_income_group
label define health_by_income_group 1 "rich/fair" 2 "rich/good" 3 "rich/excellent" 4 "nearpoor/fair" 5 "nearpoor/good" 6 "nearpoor/excellent" 7 "poor/fair" 8 "poor/good" 9 "poor/excellent"
label values health_by_income health_by_income_group
graph bar percent, over(health_by_income) asyvars ytitle("Percent") legend(col(3))



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* Try means instead of sums
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 



log close
