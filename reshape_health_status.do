clear
cap log close
cd "~/Desktop/econ381"
log using "project.log", text replace
insheet using "health_status.csv", comma


* income_region_status_year

* YEARS
reshape long i1_r1_s1_y i1_r1_s2_y i1_r1_s3_y  i1_r2_s1_y i1_r2_s2_y i1_r2_s3_y  i1_r3_s1_y i1_r3_s2_y i1_r3_s3_y  i1_r4_s1_y i1_r4_s2_y i1_r4_s3_y  i1_r5_s1_y i1_r5_s2_y i1_r5_s3_y  i2_r1_s1_y i2_r1_s2_y i2_r1_s3_y  i2_r2_s1_y i2_r2_s2_y i2_r2_s3_y  i2_r3_s1_y i2_r3_s2_y i2_r3_s3_y  i2_r4_s1_y i2_r4_s2_y i2_r4_s3_y  i2_r5_s1_y i2_r5_s2_y i2_r5_s3_y  i3_r1_s1_y i3_r1_s2_y i3_r1_s3_y  i3_r2_s1_y i3_r2_s2_y i3_r2_s3_y  i3_r3_s1_y i3_r3_s2_y i3_r3_s3_y  i3_r4_s1_y i3_r4_s2_y i3_r4_s3_y  i3_r5_s1_y i3_r5_s2_y i3_r5_s3_y  i4_r1_s1_y i4_r1_s2_y i4_r1_s3_y  i4_r2_s1_y i4_r2_s2_y i4_r2_s3_y  , i(age) j(years)
label define yearslabel 1 "1998-2000" 2 "2001-2003" 3 "2004-2006" 4 "2007-2009" 5 "2010-2012"
label values years yearslabel

rename *_y *

* STATUS
reshape long i1_r1_s i1_r2_s i1_r3_s i1_r4_s i1_r5_s i2_r1_s i2_r2_s i2_r3_s i2_r4_s i2_r5_s i3_r1_s i3_r2_s i3_r3_s i3_r4_s i3_r5_s i4_r1_s i4_r2_s i4_r3_s i4_r4_s i4_r5_s, i(age years) j(status)
label define statuslabel 1 "excellent/very good" 2 "good" 3 "fair/poor"
label values status statuslabel

rename *_s *

* REGION
reshape long i1_r i2_r i3_r i4_r, i(age years status) j(region)
label define regionlabel  1 "northeast"  2 "midwest"  3 "south"  4 "mountain" 5 "pacific"
label values region regionlabel

rename *_r *

* INCOME
reshape long i, i(age years status region) j(income)
label define incomelabel 1 "all" 2 "poor" 3 "near poor" 4 "nonpoor"
label values income incomelabel

* cleaning the data
replace i = . if i == 999
rename i percent

* labeling
label var years "Years"
label var status "Health Status"
label var region "Region"
label var income "Income"
label var percent "Percent of Incidence"

* generate status dummies
gen status_excellent = status == 1
gen status_good      = status == 2
gen status_fair      = status == 3

* generate region dummies
gen region_ne = region == 1
gen region_me = region == 2
gen region_s  = region == 3
gen region_m  = region == 4
gen region_p  = region == 5

* generate income dummies
gen income_all      = income == 1
gen income_poor     = income == 2
gen income_nearpoor = income == 3
gen income_nonpoor  = income == 4


* as expected, being poor leads to higher incidence
reg percent income_poor if status_fair & region_ne

* as expected, being nonpoor leads to lower incidence
reg percent income_nonpoor if status_fair & region_ne

graph bar percent, over(income) asyvars ytitle("Percent")

log close
