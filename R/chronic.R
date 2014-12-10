setwd("~/Desktop/econ381")
data = read.csv("reshape/adult_mortality_per_hundred_thousand.csv", header=T)

for (c in 1:10) {
  for (y in 1:4) {
    s = paste0("data$`C",c,"_y",y,"`")
    eval(parse(text=paste0(s,"[",s,"==999] <- NA")))
  }
}
View(data)

# C11 = Chronic
# C12 = Non-chronic
# Create columns for CHRONIC and NON-CHRONIC mortality rates for specific state/period
data[c("C11_y1","C11_y2","C11_y3","C11_y4","C12_y1","C12_y2","C12_y3","C12_y4")] <- NA

# 1 "all" 
# 2 "cancer"
# 3 "diabetes" 
# 4 "cardiovascular disease" 
# 5 "heart disease" 
# 6 "ischemic heart disease" 
# 7 "heart attack" 
# 8 "stroke" 
# 9 "chronic lower respirator" 
# 10 "chronic liver disease and cirrhosis"
data["C11_y1"] <- NA
for (row in 1:length(data$State)) {
  data$C11_y1[row] <- sum(c(data$C2_y1[row], data$C3_y1[row], data$C4_y1[row], data$C5_y1[row], data$C6_y1[row], data$C9_y1[row], data$C10_y1[row]), na.rm=T)
}

data["C11_y2"] <- NA
for (row in 1:length(data$State)) {
  data$C11_y2[row] <- sum(c(data$C2_y2[row], data$C3_y2[row], data$C4_y2[row], data$C5_y2[row], data$C6_y2[row], data$C9_y2[row], data$C10_y2[row]), na.rm=T)
}

data["C11_y3"] <- NA
for (row in 1:length(data$State)) {
  data$C11_y3[row] <- sum(c(data$C2_y3[row], data$C3_y3[row], data$C4_y3[row], data$C5_y3[row], data$C6_y3[row], data$C9_y3[row], data$C10_y3[row]), na.rm=T)
}

data["C11_y4"] <- NA
for (row in 1:length(data$State)) {
  data$C11_y4[row] <- sum(c(data$C2_y4[row], data$C3_y4[row], data$C4_y4[row], data$C5_y4[row], data$C6_y4[row], data$C9_y4[row], data$C10_y4[row]), na.rm=T)
}

data["C12_y1"] <- NA
for (row in 1:length(data$State)) {
  data$C12_y1[row] <- sum(c(data$C7_y1[row], data$C8_y1[row]), na.rm=T)
}

data["C12_y2"] <- NA
for (row in 1:length(data$State)) {
  data$C12_y2[row] <- sum(c(data$C7_y2[row], data$C8_y2[row]), na.rm=T)
}

data["C12_y3"] <- NA
for (row in 1:length(data$State)) {
  data$C12_y3[row] <- sum(c(data$C7_y3[row], data$C8_y3[row]), na.rm=T)
}

data["C12_y4"] <- NA
for (row in 1:length(data$State)) {
  data$C12_y4[row] <- sum(c(data$C7_y4[row], data$C8_y4[row]), na.rm=T)
}

write.csv(data, file="adult_mortality2.csv")
View(data)

long <- reshape(data,
                varying = c("C1_y1", "C1_y2", "C1_y3", "C1_y4",
                            "C2_y1", "C2_y2", "C2_y3", "C2_y4",
                            "C3_y1", "C3_y2", "C3_y3", "C3_y4",
                            "C4_y1", "C4_y2", "C4_y3", "C4_y4",
                            "C5_y1", "C5_y2", "C5_y3", "C5_y4",
                            "C6_y1", "C6_y2", "C6_y3", "C6_y4",
                            "C7_y1", "C7_y2", "C7_y3", "C7_y4",
                            "C8_y1", "C8_y2", "C8_y3", "C8_y4",
                            "C9_y1", "C9_y2", "C9_y3", "C9_y4",
                            "C10_y1", "C10_y2", "C10_y3", "C10_y4",
                            "C11_y1", "C11_y2", "C11_y3", "C11_y4",
                            "C12_y1", "C12_y2", "C12_y3", "C12_y4"
                            ),
                v.names = c("all", "cancer", "diabetes", 
                            "cardiovascular_disease", "heart_disease", 
                            "ischemic_heart_disease", "heart_attack", 
                            "stroke", "chronic_lower_respirator", 
                            "chronic_liver_disease_and_cirrhosis", 
                            "chronic", "nonchronic"),
                timevar = "years",
                times = c("2000-2002", "2003-2005", "2006-2008", "2009-2011"),
                new.row.names = 1:208,
                direction = "long")
