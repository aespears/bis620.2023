#' Accelerometry Data Resampled from UK Biobank
#'
#' Toy accelerometry data for BIS620
#'
#' @format ## `accel`
#' A data frame with 1,080,000 rows and 4 columns:
#' \describe{
#'   \item{time}{the time of the measurement}
#'   \item{X, Y, Z}{Accelerometry measurement (in milligravities).}
#' }
"accel"

#'
#' Conditions
#'
#' Taken from ctgov database table, lists conditions
#' @format ## `conditions`
#' A data frame with 822,729 rows and 4 columns:
#' \describe{
#'   \item{id}{A unique identifier}
#'   \item{nct_id}{The NCT id, another identifier}
#'   \item{name}{The name of the condition}
#'   \item{downcase_name}{The same as name but all lowercase}
#' }
"conditions"

#'
#' Countries
#'
#' Taken from ctgov database table, gives the country for each trial
#' @format ## `countries`
#' A data frame with 658,829 rows and 4 columns:
#' \describe{
#'   \item{id}{A unique identifier}
#'   \item{nct_id}{The NCT id, another identifier}
#'   \item{name}{The name of the country}
#'   \item{removed}{True or False}
#' }
"countries"

#'
#' Sponsors
#'
#' Taken from ctgov database table, lists sponsors
#' @format ## `sponsors`
#' A data frame with 761678 rows and 5 columns:
#' \describe{
#'   \item{id}{A unique identifier}
#'   \item{nct_id}{The NCT id, another identifier}
#'   \item{agency_class}{What type of sponsor is listed}
#'   \item{lead_or_collaborator}{Whether the sponsor was the lead or collaborator for the trial}
#'   \item{name}{Name of the sponsor}
#' }
"sponsors"

#'
#' Studies
#'
#' Taken from ctgov database table, lists all the studies
#' @format ## `studies`
#' A data frame with 474773 rows and 70 columns:
#' \describe{
#'   \item{nct_id}{The NCT id, another identifier}
#'   \item{study_first_submitted_date}{Date the study was first submitted}
#'   \item{results_first_submitted_date}{Date the results of the study were first submitted}
#'   ...
#' }
"studies"
