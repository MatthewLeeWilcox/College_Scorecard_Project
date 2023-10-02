library(tidyverse)
library(data.table)
current_directory <- getwd()
data_path <- '/Data/RAW_DATA/MERGED2021_22_PP.csv'

df_complete <- fread(paste(current_directory, data_path, sep = ""))


interested_columns <- c('INSTNM', 'CITY', 'STABBR', 'ZIP')

df_complete %>% select(interested_columns)


df2 <-df_complete %>% select(INSTNM, CITY,STABBR, ZIP, HCM2, ST_FIPS,
                             REGION, LOCALE2, LATITUDE, LONGITUDE, RELAFFIL,
                             SATVR25, SATVR75, SATMT25, SATMT75, SATWR25, SATWR75,
                             SATVRMID, SATMTMID, SATWRMID, ACTCM25, ACTCM75, ACTEN25,
                             ACTEN75, ACTMT25, ACTMT75, ACTWR25, ACTWR75, ACTCMMID, ACTENMID,
                             ACTMTMID, ACTWRMID, SAT_AVG, SAT_AVG_ALL, NPT4_PUB, NPT45_PRIV,
                             NPT4_PROG, NPT4_OTHER, TUITIONFEE_IN, TUITIONFEE_OUT, PCTPELL
                        )
df2[df2 == "NULL"] <- NA

write.csv(df2, paste(current_directory, '/Data/Shrunk_data.csv', sep = ""))
                             
                             