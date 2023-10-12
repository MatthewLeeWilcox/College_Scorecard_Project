library(tidyverse)
library(data.table)
library(usdata)
library(stringr)
# Data directory
current_directory <- getwd()
data_path <- '/Data/Shrunk_data.csv'

# Read in Data
df <- fread(paste(current_directory, data_path, sep = ""))

df[df == "Null"]<- NA

uni_names_df <- df %>% select('INSTNM', 'CITY', 'STABBR', 'ZIP') %>%
  rename('instution' = 'INSTNM',
         'city' = 'CITY', 
         'state_abbr' = 'STABBR',
         'zip' = 'ZIP')

uni_names_df$vector_name<- strsplit(uni_names_df$instution, split = " ")


state_mapping <- setNames(state.name, state.abb)

uni_names_df$state_name <- state_mapping[uni_names_df$state_abbr]

uni_names_df$state_name_included <- str_detect(tolower(uni_names_df$instution),tolower(uni_names_df$state_name))

uni_names_df$city_name_included <- str_detect(tolower(uni_names_df$instution), tolower(uni_names_df$city))


uni_names_df %>% group_by(state_abbr, city, city_name_included) %>% 
  summarise(total_count=n(),
            .groups = 'drop')%>% arrange(desc(total_count))

