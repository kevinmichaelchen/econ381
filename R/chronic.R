setwd("~/Desktop/econ381")
data = read.csv("reshape/adult_mortality_per_hundred_thousand.csv", header=T)

for (c in 1:10) {
  for (y in 1:4) {
    s = paste0("data$`C",c,"_y",y,"`")
    eval(parse(text=paste0(s,"[",s,"==999] <- NA")))
  }
}
View(data)

data[c("chronic_y1","chronic_y2","chronic_y3","chronic_y4","nonchronic_y1","nonchronic_y2","nonchronic_y3","nonchronic_y4")] <- NA

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
data["chronic_y1"] <- NA
data$chronic_y1 <- data$C2_y1 + data$C3_y1 + data$C4_y1 + data$C5_y1 + data$C6_y1 + data$C9_y1 + data$C10_y1

data["chronic_y2"] <- NA
data$chronic_y2 <- data$C2_y2 + data$C3_y2 + data$C4_y2 + data$C5_y2 + data$C6_y2 + data$C9_y2 + data$C10_y2

data["chronic_y3"] <- NA
data$chronic_y3 <- data$C2_y3 + data$C3_y3 + data$C4_y3 + data$C5_y3 + data$C6_y3 + data$C9_y3 + data$C10_y3

data["chronic_y4"] <- NA
data$chronic_y4 <- data$C2_y4 + data$C3_y4 + data$C4_y4 + data$C5_y4 + data$C6_y4 + data$C9_y4 + data$C10_y4

data["nonchronic_y1"] <- NA
data$nonchronic_y1 <- data$C7_y1 + data$C8_y1

data["nonchronic_y2"] <- NA
data$nonchronic_y2 <- data$C7_y2 + data$C8_y2

data["nonchronic_y3"] <- NA
data$nonchronic_y3 <- data$C7_y3 + data$C8_y3

data["nonchronic_y4"] <- NA
data$nonchronic_y4 <- data$C7_y4 + data$C8_y4

data[1:10,1:5]
write.csv(data, file="adult_mortality2.csv")
View(data)
