*Muhammad Ghazi Randhawa
*Final Project

clear
set more off
capture restore
capture log close

*--------------------
* Directory Configuration
*--------------------


	
*Ghazi Randhawa
if "`c(username)'" == "ghazi" {
    global root = "/Users/ghazi/Desktop/Final_Project_GEG"
    }


global data = "$root/Data"
global output = "$root/Output"
global logs = "$root/Log"
	
**read in the file

import delimited "$data/survey_data.csv",clear

*convert variables of interest to numerics

encode geotype, gen(geotype_nu)
*drop non-state unit data
drop if geotype_nu != 4

*merge with the new dataset
encode geoname, gen(states)
merge m:1 states using "$data/rankings_states.dta"


*regression of discussing climate change with vulnerability 
reg discuss vulnerability 
eststo reg1a
reg discuss preparedness 
eststo reg1b
reg discuss preparedness vulnerability
eststo reg1c

*esttab reg1a reg1b reg1c using "$output/discuss.rtf", mtitles("Vulnerability" "Preparedness" "vulnerability and Preparedness") stats(N r2 F, labels("Observations" "R-squared" "F-stat"))


*regression of voting pattern and preparedness
reg gwvoteimp preparedness 
eststo reg2a

reg gwvoteimp vulnerability 
eststo reg2b

reg gwvoteimp vulnerability preparedness
eststo reg2c

*esttab reg2a reg2b reg2c using "$output/voter.rtf", mtitles("Vulnerability" "Preparedness" "vulnerability and Preparedness") stats(N r2 F, labels("Observations" "R-squared" "F-stat"))


*regression of timing of CC on vulnerability and preparedness
reg timing preparedness
eststo reg3a

reg timing vulnerability
eststo reg3b

reg timing vulnerability preparedness
eststo reg3c


*esttab reg3a reg3b reg3c using "$output/Climate_change.rtf", mtitles("Vulnerability" "Preparedness" "vulnerability and Preparedness") stats(N r2 F, labels("Observations" "R-squared" "F-stat"))










