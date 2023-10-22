library(dplyr)
library(ggplot2)
library(data.table)

# Load your data
Shrunk_data <- read.csv("C:/Users/rayli/Desktop/Data Munging/Project/College_Scorecard_Project/Data/Shrunk_data.csv")

Shrunk_data$SAT_AVG <- as.numeric(Shrunk_data$SAT_AVG)


Shrunk_data %>% ggplot(aes(REGION, SAT_AVG)) +geom_boxplot()
Shrunk_data %>% ggplot(aes(SAT_AVG)) + geom_histogram() + facet_wrap(~Shrunk_data$REGION) 
#we can see the SAT scores are  roughly symmertrical for most regions. 
 