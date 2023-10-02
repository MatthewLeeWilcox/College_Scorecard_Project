library(tidyverse)
library(data.table)

# Data Set Dir
current_directory <- getwd()
data_path <- '/Data/Shrunk_data.csv'
data_path_raw <- '/Data/RAW_DATA/MERGED2021_22_PP.csv'

df_raw <-  fread(paste(current_directory, data_path_raw, sep = ""))
df <- fread(paste(current_directory, data_path, sep = ""))


# Deal with Null Values in Raw
df_raw[df_raw == "NULL"] <- NA


# Use Column Means to get the Percentage of the values that are not NA.
# ie 100% means no missing values
pct_variables_included <- colMeans(!is.na(df)) *100
pct_variables_included_raw <- colMeans(!is.na(df_raw))*100


# Return a DF that shows percentage of values that are not NA. 
df <- data.frame(
  variable_name = colnames(df_raw),
  pct_included = pct_variables_included_raw
)
