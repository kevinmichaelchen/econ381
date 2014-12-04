* GRAPH MORTALITY OVER STATE
graph bar cancer diabetes cardio heart_disease ischemic ///
 heart_attack stroke respiratory cirrhosis, ///
 over(state_abbrev, label(labsize(miniscule))) nolabel asyvars stack showyvars title("Mortality by state") ytitle("Per hundred thousand mortality")
graph export mortality_by_state.png