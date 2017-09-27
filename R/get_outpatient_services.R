
#' @name get_outpatient_services
#' @title extract data from the outpatient services table

#' @description The outpatient_services family of functions (\code{\link{get_outpatient_services}})
#' provides an interface to query the outpatient_services table in the Truven Marketscan Health
#' Research Database. The \code{get_outpatient_services} function extracts data verbatim from the
#' outpatient_servives table. The \code{get_patient_id_outpatient} function extracts the index date
#' (i.e., the first date of service) corresponding to patient ids (generally the 'enrolid') within
#' the given date range and if applicable, optional parameters.
#'
#' @param optional_q_table_name an optional field where the name of the outpatient_services table
#' may be passed. The function sets a default table name called "outpatient_services" which is used
#' when the user does not provide a table name
#'
#' @param columns_to_return a character vector of columns names corresponding to the names of the table
#' headers (columns) in the outpatient services table.
#'
#' @param start the start date for the query. This should be of the form yyyy.mm.dd and must be passed
#' as a character. For example, to pass June 30, 2017, the value of the start parameter should be
#' "2017.06.30"
#'
#' @param end the end date for the query. This should be of the form yyyy.mm.dd and must be passed
#' as a character. For example, to pass Nov. 30, 2017, the value of the start parameter should be
#' "2017.11.30"
#'
#' @param optional_diag_codes a character vector of dx (diagnosis) codes
#'
#' @param optional_enrolids an integer vector of enrolid values
#'
#' @param return_all_flag a boolean value indicating whether all the data should be returned to R.
#' This parameter generally defaults to FALSE since returning large amounts of data to the R Session
#' may take time. It should be set to TRUE only if you are certain that you'd like to load all the
#' data that is a result of the query into your session.
#'
#' @param api_function a variable indicating the name of the function. It is unlikely that you'll ever
#' need to change the value of this parameter and it is best left as-is
#'
#' @param get_stats a boolean variable indicating whether query statistics should be printed
#'
#' @details The outpatient_services functions allow the user to retrieve data from the outpatient_services
#' table in the Truven Health MarketScan® Research Database.
#'
#' The Outpatient Services dataset is part of the Truven Health Marketscan's Commercial Claims & Encounters
#' database that contains claims information for services provided in a doctor's office, emergency rooms,
#' and other similar settings not requiring a hospital stay. The table provides detailed information on
#' pre-admission treatment such as diagnosis codes, co-insurance amounts and other variables. It also contains
#' detailed patient-level demographic data such as age, gender, employment-related information and others on
#' a per-record basis. Additional information from Truven: "A small percentage of claims in this table may
#' represent inpatient services, because the claim was not incorporated into an inpatient admission (e.g.,
#' no room and board charge was found). These claims generally have an “inpatient” Place of Service (STDPLAC)
#' code."
#'
#' @return A data.table with the results of the query
#'
#' @export
#' @examples
#'
#' # extract data from outpatient_services table
#'
#' # extract age and month from outpatient_services between svcdates 2015.03.04 and 2015.03.07 for diagnosis (dx)
#' # codes (\code{c("32723","4439")}) and enrolids \code{c(8601,12901)}
#'
#' get_outpatient_services(columns_to_return=c("age","month"),start="2015.03.04",end="2015.03.07",
#' optional_diag_codes=c("32723","4439"), optional_enrolids=c(8601,12901),return_all_flag=F,get_stats="TRUE")
#'
#' # extract age and month from outpatient_services between svcdates 2015.03.04 and 2015.03.05 for diagnosis (dx)
#' # codes (\code{c("32723","4439")}) and return all data
#'
#' get_outpatient_services(columns_to_return=c("age","month"),start="2015.03.04",end="2015.03.05",
#' optional_diag_codes=c("32723","4439"),return_all_flag=T,get_stats="TRUE")
#'

get_outpatient_services <- function(optional_q_table_name="outpatient_services",columns_to_return,
                                    start,end,optional_diag_codes="__NULL__",optional_enrolids="__NULL__",return_all_flag=F,api_function="get_outpatient_services",...){

  paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
                        columns_to_return=columns_to_return,optional_diag_codes=optional_diag_codes,
                        start=start,end=end,optional_enrolids=optional_enrolids,
                        return_all_flag=return_all_flag,...)

  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}

#' @rdname get_outpatient_services
#' @export
get_patient_id_outpatient <- function(optional_q_table_name="outpatient_services",start,end,optional_diag_codes="__NULL__",
                                      optional_enrolids="__NULL__",return_all_flag=F,api_function="get_patient_id_outpatient",...){
  get_outpatient_services(optional_q_table_name=optional_q_table_name,start=start,end=end,columns_to_return="__NULL__",api_function=api_function,
                          optional_diag_codes=optional_diag_codes,optional_enrolids=optional_enrolids,return_all_flag=T,...)
}
