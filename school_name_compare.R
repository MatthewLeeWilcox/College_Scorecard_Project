library(tidyverse)
library(data.table)
library(usdata)
library(stringr)
library(ggplot2)
library(usmap)
library(maps)
library(mapdata)
# Data directory
current_directory <- getwd()
data_path <- '/Data/locale_descript_data.csv'

# Read in Data
df_shrink <- fread(paste(current_directory, data_path, sep = ""))

# Make Null NA
df_shrink[df_shrink == "Null"]<- NA

# Select columns Used and Rename
uni_names_df <- df_shrink %>%
  rename('instution' = 'INSTNM',
         'city' = 'CITY', 
         'state_abbr' = 'STABBR',
         'zip' = 'ZIP')


# Create a vector of all univeristys names
uni_names_df$vector_name<- strsplit(uni_names_df$instution, split = " ")


# Map the State Abbreviations to actual State Names and create columm state_names
state_mapping <- setNames(state.name, state.abb)

uni_names_df$state_name <- state_mapping[uni_names_df$state_abbr]

# Build Boolean Variable state_name_included if state name is in the university name
uni_names_df$state_name_included <- str_detect(tolower(uni_names_df$instution),tolower(uni_names_df$state_name))

# Build Boolean Variable city_name_included if city is in the university name
uni_names_df$city_name_included <- str_detect(tolower(uni_names_df$instution), tolower(uni_names_df$city))



# Count of total colleges per city
total_colleges_per_city <- uni_names_df %>% group_by(state_abbr, city) %>%
  summarise(total_count=n())%>% arrange(desc(total_count))

total_colleges_per_city_20 <- head(total_colleges_per_city, 20)
# Graph previous

ggplot(data = total_colleges_per_city_20, aes(x = reorder(city, total_count), y = total_count)) + 
  geom_bar(stat = "identity") +
  coord_flip() + 
  labs(
    title = "Number of College in Each City"
  ) + 
  xlab("City") + 
  ylab("Number of Colleges")


# Group by the city and if the city name is included and count.
city_name_groupby <- uni_names_df %>% group_by(state_abbr, city, city_name_included) %>% 
  summarise(total_count=n(),
            .groups = 'drop')%>% arrange(desc(total_count))

# Group by the State 
state_name_groupby <- uni_names_df %>% group_by(state_abbr, state_name_included) %>% 
  summarise(total_count=n(),
            .groups = 'drop')%>% arrange(desc(total_count)) %>%
  filter(state_name_included == TRUE)%>% 
  rename('state' = 'state_abbr')

# Plot States
# states_map <- map_data("state")
# state_name_groupby$region <- tolower(state_mapping[state_name_groupby$state_abbr])
# state_name_groupby_map <- left_join(states_map, state_name_groupby, by = "region")
# 
# ggplot(state_name_groupby_map, aes(long, lat, group = group))+
#   geom_polygon(aes(fill = total_count)) 


plot_usmap(data = state_name_groupby, values = "total_count") + 
  labs(
    title = "Number of College with State Name in University Name",
    fill = "Number of Colleges"
  )
library(leaflet)





write_csv(uni_names_df, paste(current_directory,"/Data/uni_names_vecotrized.csv", sep = ""))




