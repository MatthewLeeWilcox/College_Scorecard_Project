library(tidyverse)
library(data.table)
library(dplyr)
library(leaflet)
# Data directory
current_directory <- getwd()
data_path <- '/Data/uni_names_vectorized.csv'

# Read_csv

df <- fread(paste(current_directory, data_path, sep = ""))

df <- df %>% mutate(urban_color = case_when(
  urban_type == "City" ~ "redc",
  urban_type == "Suburb" ~ "bluec",
  urban_type == "Town" ~ "greenc",
  urban_type == "Rural" ~ "yellowc"
)  )
df$pop_up_discript <- paste("Insitution Name:", df$instution, "<br/> ",
                            "State: ", df$state_name, "<br/> ",
                            "City: ", df$city, "<br/> ",
                            "Urban: ", df$urban_type, "-", df$urban_description, "\n")



my_icons <- iconList(
  # pink = makeIcon(paste(current_directory, "/Icons/pink_icon.png", sep = ""),paste(current_directory, "/Icons/pink_icon.png", sep = ""),15,15),
  redc = makeIcon(paste(current_directory, "/Icons/red_icon.png", sep = ""),paste(current_directory, "/Icons/red_icon.png", sep = ""),15,15),
  # purple = makeIcon(paste(current_directory, "/Icons/purple_icon.png", sep = ""),paste(current_directory, "/Icons/purple_icon.png", sep = ""),15,15),
  # white = makeIcon(paste(current_directory, "/Icons/white_icon.png", sep = ""),paste(current_directory, "/Icons/white_icon.png", sep = ""),15,15),
  yellowc = makeIcon(paste(current_directory, "/Icons/yellow_icon.png", sep = ""),paste(current_directory, "/Icons/yellow_icon.png", sep = ""),15,15),
  greenc = makeIcon(paste(current_directory, "/Icons/green_icon.png", sep = ""),paste(current_directory, "/Icons/green_icon.png", sep = ""),15,15),
  bluec = makeIcon(paste(current_directory, "/Icons/blue_icon.png", sep = ""),paste(current_directory, "/Icons/blue_icon.png", sep = ""),15,15)
  # black = makeIcon(paste(current_directory, "/Icons/black_icon.png", sep = ""),paste(current_directory, "/Icons/black_icon.png", sep = ""),15,15),
  # orange = makeIcon(paste(current_directory, "/Icons/orange_icon.png", sep = ""),paste(current_directory, "/Icons/orange_icon.png", sep = ""),15,15)

)



map_uni <- leaflet(df) %>%
  addProviderTiles(providers$CartoDB.PositronNoLabels) %>% 
  addMarkers(lng = ~LONGITUDE,
             lat = ~LATITUDE,
             popup = ~pop_up_discript,
             ) %>%
  setView(lng = -96.25, lat = 39.50, zoom = 4)
map_uni
