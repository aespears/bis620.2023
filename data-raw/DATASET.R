## code to prepare `DATASET` dataset goes here

accel = readRDS("accel.rds")
conditions = readRDS("conditions.rds")
countries = readRDS('countries.rds')
sponsors = readRDS('sponsors.rds')
studies = readRDS('studies.rds')
usethis::use_data(accel, conditions, countries, sponsors, studies, overwrite = TRUE)

