# Include psych package

library(psych)

<<<<<<< HEAD
=======

>>>>>>> 2466edf175a3c69eabc548936feda00f5b96a19e
# Generate N number of trials ---------------------------------------------

n <- 150
not_useful <- 3
cases <- 2

<<<<<<< HEAD
=======

>>>>>>> 2466edf175a3c69eabc548936feda00f5b96a19e
# Generate randomized trials for N = 150 ----------------------------------

trials <-  block.random(n,c(not_useful, cases))
headTail(trials)
output <- data.frame(trials)
colnames(output) <- c("Block no.","to_be_discarded","Case")

# Write CSV file ----------------------------------------------------------

# Discarding second column which contains non-relevent data
write.csv(output[,-2],"Randomized_trials.csv")
pairs.panels(trials)
plot(trials,type = 'l')
