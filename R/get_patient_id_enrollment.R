
#' @name get_patient_id_enrollment
#' @title extract data from the detail enrollment table

#' @description The \code{get_patient_id_enrollment} function provides an interface
#' to query the detail enrollment table in the Truven Marketscan Health Research Database
#' The \code{get_patient_id_enrollment} function extracts the index date (i.e.,
#' the first date of service) corresponding to patient ids (generally the 'enrolid')
#' within the given date range and if applicable, optional parameters
#'
#' @param optional_q_table_name an optional field where the name of the table may be passed.
#' The function sets a default table name called "detail_enrollment" which is used
#' when the user does not provide a table name
#'
#' @param start the start date for the query. This should be of the form yyyy.mm.dd and must be passed
#' as a character. For example, to pass June 30, 2017, the value of the start parameter should be
#' "2017.06.30"
#'
#' @param end the end date for the query. This should be of the form yyyy.mm.dd and must be passed
#' as a character. For example, to pass Nov. 30, 2017, the value of the start parameter should be
#' "2017.11.30"
#'
#' @param optional_enrolids an integer vector of enrolid values
#'
#' @param return_all_flag a boolean value indicating whether all the data should be returned to R.
#' This parameter generally defaults to FALSE since returning large amounts of data to the R Session
#' may take time. It should be set to TRUE only if you are certain that you'd like to load all the
#' data generated as a result of the query into your session.
#'
#' @param api_function a variable indicating the name of the function. It is unlikely that you'll ever
#' need to change the value of this parameter and it is best left as-is
#'
#' @param get_stats a boolean variable indicating whether query statistics should be printed
#'
#' @details The \code{get_patient_id_enrollment} function allow the user to retrieve
#' data from the detail_enrollment table in the Truven Health MarketScan® Research Database. The Detail Enrollment
#' dataset is part of the Truven Health Marketscan's  database and contains information on use of insurance services
#' by patients as given in the MarketScan Commercial Claims and Encounters and Medicare Supplemental Databases. For
#' each patient, a record is generated on a per-month basis and is an indicator of whether the person was enrolled
#' in an insurance plan. The table provides information on patient demographics such as age, gender,
#' employment-related information in addition to plan-related information.
#'
#' Additional information from Truven: There are also variables indicating the number of months during the year with
#' enrollment and the total annual enrollment days. The Enrollment Detail Table contains one record per person per month
#' of enrollment for an individual enrollee regardless of whether any demographic values have changed from the previous
#' month. If you need to track changes in variables such as Cohort Drug Indicator (RX) or Geographic Location of Employee
#' (EGEOLOC), use the Enrollment Detail Table.
#'
#' Beginning with the 2001 data, all data contributors submit person-level enrollment information. When using MarketScan
#' database releases prior to 2001, the Enrollment Flag (ENRFLAG) variable allows the user to select only claims supported
#' by person- level enrollment. When ENRFLAG=1, it indicates that person-level enrollment information is available for
#' that data contributor.
#'
#' @return A data.table with the results of the query
#'
#' @export
#' @examples
#'
#' # extract data from detail_enrollment table
#'
#' # extract enrolids from detail enrollment table between svcdates 2009.01.01 and
#' # 2009.03.01 that had continous enrollment for the given months (2009.01 to 2009.03)
#'
#' get_patient_id_enrollment(start="2009.01.01",end="2009.03.01",get_stats="TRUE")
#'
#' # extract enrolids from detail enrollment table between svcdates 2010.01.01 and
#' # 2010.06.01 that had continous enrollment for the given months (2010.01 to 2010.06) and
#' # filter for enrolids c(8929201,53402,902)
#'
#' get_patient_id_enrollment(start="2010.01.01",end="2010.06.01",optional_enrolids=c(8929201,53402,
#' 902),get_stats="TRUE")
#'
get_patient_id_enrollment <- function(optional_q_table_name="detail_enrollment",start,end,
    optional_enrolids="__NULL__",api_function="get_patient_id_enrollment",return_all_flag=F, ...){

  paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
                        start=start,end=end,optional_enrolids=optional_enrolids,
                        return_all_flag=return_all_flag,...)
  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}
