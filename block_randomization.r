install.packages("psych")
library(psych)

condition <-  block.random( n= 150,c(block = 3,drug = 2))
headTail(condition)
write.csv(condition,"randomized_design.csv")
pairs.panels(condition)
plot(condition,type = 'l')
