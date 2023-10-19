library(tidyverse)
library(data.table)
library(dplyr)
# Data directory
current_directory <- getwd()
data_path <- '/Data/Shrunk_data.csv'

# Read_csv

df <- fread(paste(current_directory, data_path, sep = ""))

# Create Urban_type and Urban_description
df2 <- df %>% select(INSTNM, CITY, ZIP, STABBR, LOCALE, LATITUDE, LONGITUDE) %>%
  mutate(urban_type = case_when(
  LOCALE == 11 ~ "City",
  LOCALE == 12 ~ "City",
  LOCALE == 13 ~ "City",
  LOCALE == 21 ~ "Suburb",
  LOCALE == 22 ~ "Suburb",
  LOCALE == 23 ~ "Suburb",
  LOCALE == 31 ~ "Town",
  LOCALE == 32 ~ "Town",
  LOCALE == 33 ~ "Town",
  LOCALE == 41 ~ "Rural",
  LOCALE == 42 ~ "Rural",
  LOCALE == 43 ~ "Rural"
  ),
  urban_description =case_when(
    LOCALE == 11 ~ "Large",
    LOCALE == 12 ~ "Midsize",
    LOCALE == 13 ~ "Small",
    LOCALE == 21 ~ "Large",
    LOCALE == 22 ~ "Midsize",
    LOCALE == 23 ~ "Small",
    LOCALE == 31 ~ "Fringe",
    LOCALE == 32 ~ "Distant",
    LOCALE == 33 ~ "Remote",
    LOCALE == 41 ~ "Fringe",
    LOCALE == 42 ~ "Distant",
    LOCALE == 43 ~ "Remote"
  ) 

)
# Urban Description reference this for meaning of size:
# 11	City: Large (population of 250,000 or more)
# 12	City: Midsize (population of at least 100,000 but less than 250,000)
# 13	City: Small (population less than 100,000)
# 21	Suburb: Large (outside principal city, in urbanized area with population of 250,000 or more)
# 22	Suburb: Midsize (outside principal city, in urbanized area with population of at least 100,000 but less than 250,000)
# 23	Suburb: Small (outside principal city, in urbanized area with population less than 100,000)
# 31	Town: Fringe (in urban cluster up to 10 miles from an urbanized area)
# 32	Town: Distant (in urban cluster more than 10 miles and up to 35 miles from an urbanized area)
# 33	Town: Remote (in urban cluster more than 35 miles from an urbanized area)
# 41	Rural: Fringe (rural territory up to 5 miles from an urbanized area or up to 2.5 miles from an urban cluster)
# 42	Rural: Distant (rural territory more than 5 miles but up to 25 miles from an urbanized area or more than 2.5 and up to 10 miles from an urban cluster)
# 43	Rural: Remote (rural territory more than 25 miles from an urbanized area and more than 10 miles from an urban cluster)

write.csv(df2, paste(current_directory,"/Data/locale_descript_data.csv", sep = ""))
