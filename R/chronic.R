setwd("~/Desktop/econ381")
data = read.csv("reshape/adult_mortality_per_hundred_thousand.csv", header=T)

for (c in 1:10) {
  for (y in 1:4) {
    s = paste0("data$`C",c,"_y",y,"`")
    eval(parse(text=paste0(s,"[",s,"==999] <- NA")))
  }
}

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

#http://stackoverflow.com/questions/20029468/trouble-with-reshaping-a-data-frame
long <- reshape(data, direction = "long", idvar="State",
                varying = 2:ncol(data), 
                v.names = c("y1", "y2", "y3", "y4"),
                timevar = "cause",
                times = c("C1","C2","C3","C4","C5","C6","C7","C8","C9","C10","C11","C12"),
                new.row.names = 1:624)

long["mortality"] <- NA
for (row in 1:length(long$cause)) {
  long$mortality[row] <- sum(c(long$y1[row], long$y2[row], long$y3[row], long$y4[row]), na.rm=T)
}
long$mortality[long$mortality==0] = NA

long$cause[long$cause=="C1"] = 1
long$cause[long$cause=="C2"] = 2
long$cause[long$cause=="C3"] = 3
long$cause[long$cause=="C4"] = 4
long$cause[long$cause=="C5"] = 5
long$cause[long$cause=="C6"] = 6
long$cause[long$cause=="C7"] = 7
long$cause[long$cause=="C8"] = 8
long$cause[long$cause=="C9"] = 9
long$cause[long$cause=="C10"] = 10
long$cause[long$cause=="C11"] = 11
long$cause[long$cause=="C12"] = 12

long["chronic"] <- F
long$chronic[long$cause==2] <- T
long$chronic[long$cause==3] <- T
long$chronic[long$cause==4] <- T
long$chronic[long$cause==5] <- T
long$chronic[long$cause==6] <- T
long$chronic[long$cause==9] <- T
long$chronic[long$cause==10] <- T

long["fc"] <- F
long$fc[long$State=="Iowa"] <- T
long$fc[long$State=="Utah"] <- T
long$fc[long$State=="South Dakota"] <- T

write.csv(long, file="adult_mortality2.csv")

View(long)