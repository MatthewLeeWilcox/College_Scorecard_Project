library(tidyverse)
library(dplyr)
library(ggplot2)

# Data directory
current_directory <- getwd()
data_path <- '/Data/uni_names_vectorized.csv'

# Read_csv

df <- fread(paste(current_directory, data_path, sep = ""))

# Select variables of interest
df <- df %>% select(instution, city, state_name, state_name_included, city_name_included, urban_type, urban_description)

# Group By City DF
df_city <- df %>% drop_na() %>% 
  group_by(urban_type, city_name_included) %>%
  summarise(total_count = n(), .groups = 'drop')

# Group by State df
df_state <- df %>% drop_na()%>%
  group_by(urban_type, state_name_included) %>%
  summarise(total_count = n(), .groups = 'drop')



# Graphs

ggplot(df_city, aes(fill = city_name_included, x = urban_type, y = total_count)) +
  geom_bar(position = "fill", stat = "identity") + 
  xlab("Urbanization")+
  ylab("Percentage") + 
  labs( 
    title = "Inclusion of City name in the University name with Respect to Urbanziation",
    subtitle = "Pct Stacked",
    fill = "City Name included in College Name"
    )

ggplot(df_city, aes(fill = city_name_included, x = urban_type, y = total_count)) +
  geom_bar(position = "dodge", stat = "identity")+ 
  xlab("Urbanization")+
  ylab("Count") + 
  labs( 
    title = "Inclusion of City name in the University name with Respect to Urbanziation",
    subtitle = "Grouped",
    fill = "City Name included in College Name"
  )

ggplot(df_city, aes(fill = city_name_included, x = urban_type, y = total_count)) +
  geom_bar(position = "stack", stat = "identity")+ 
  xlab("Urbanization")+
  ylab("Count") + 
  labs( 
    title = "Inclusion of City name in the University name with Respect to Urbanziation",
    subtitle = "Stacked",
    fill = "City Name included in College Name"
  )

ggplot(df_state, aes(fill = state_name_included, x = urban_type, y = total_count)) +
  geom_bar(position = "fill", stat = "identity")+ 
  xlab("Urbanization")+
  ylab("Percentage") + 
  labs( 
    title = "Inclusion of State name in the University name with Respect to Urbanziation",
    subtitle = "Pct Stacked",
    fill = "State Name included in College Name"
  )

ggplot(df_state, aes(fill = state_name_included, x = urban_type, y = total_count)) +
  geom_bar(position = "dodge", stat = "identity")+ 
  xlab("Urbanization")+
  ylab("Count") + 
  labs( 
    title = "Inclusion of State name in the University name with Respect to Urbanziation",
    subtitle = "Grouped",
    fill = "State Name included in College Name"
  )

ggplot(df_state, aes(fill = state_name_included, x = urban_type, y = total_count)) +
  geom_bar(position = "stack", stat = "identity")+ 
  xlab("Urbanization")+
  ylab("Count") + 
  labs( 
    title = "Inclusion of State name in the University name with Respect to Urbanziation",
    subtitle = "Stacked",
    fill = "State Name included in College Name"
  )

