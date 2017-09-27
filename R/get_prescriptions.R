
#' @name get_prescriptions
#' @title extract data from the prescription drug table

#' @description The get_prescriptions family of functions (\code{\link{get_prescriptions}})
#' provides an interface to query the prescriptions drug table in the Truven Marketscan Health
#' Research Database. The \code{get_prescriptions} function extracts data verbatim from the
#' prescriptions_drug table. The \code{get_patient_id_prescriptions} function extracts the index date
#' (i.e., the first date of service) corresponding to patient ids (generally the 'enrolid') within
#' the given date range and if applicable, optional parameters.
#'
#' @param optional_q_table_name an optional field where the name of the prescriptions table
#' may be passed. The function sets a default table name called "prescriptions" which is used
#' when the user does not provide a table name
#'
#' @param columns_to_return a character vector of columns names corresponding to the names of the table
#' headers (columns) in the inpatient services table.
#'
#' @param start the start date for the query. This should be of the form yyyy.mm.dd and must be passed
#' as a character. For example, to pass June 30, 2017, the value of the start parameter should be
#' "2017.06.30"
#'
#' @param end the end date for the query. This should be of the form yyyy.mm.dd and must be passed
#' as a character. For example, to pass Nov. 30, 2017, the value of the start parameter should be
#' "2017.11.30"
#'
#' @param optional_ndc_codes a character vector of ndcnum (NDC) codes
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
#' @details The \code{get_prescriptions} & \code{get_patient_id_prescriptions} functions allow the user to retrieve
#' data from the prescriptions table in the Truven Health MarketScan® Research Database.
#'
#' The Pharmaceutical Claims Data (Prescription Drug) dataset is part of the Truven Health Marketscan's Commercial
#' Claims & Encounters database and contains claims for drugs filled at pharmacies. The table provides detailed
#' information on the drugs dispensed, including data on days of supply, ingredient cost, NDC number, Refill indicator
#' and other important variables. Apart from drug-related information, the dataset also contains detailed patient-level
#' demographic data such as age, gender, employment-related information and others on a per-record basis.
#' Additional information from Truven: The outpatient pharmaceutical data are linked by ENROLID to the medical/surgical
#' data. Each record represents either a mail-order or card program prescription drug claim.
#'
#' Note: Before you begin your analysis, carefully determine which data sources (e.g., medical/surgical, outpatient
#' pharmaceutical, enrollment) will be necessary to support your analytic plan. If you require more than one of these
#' data sources, it first may be necessary to utilize the various cohort flags to determine which data contributors
#' or plans have the required data (via RX, MHSACOVG, and/or EIDFLAG/ENRFLAG variables).
#'
#' @return A data.table with the results of the query
#'
#' @export
#' @examples
#'
#' # extract data from prescriptions table
#'
#' # extract enrolid, ndcnum and svcdate from prescription drug table between svcdates 2015.03.04
#' # and 2015.03.07 for ndcnum (NDC) code c("00555099702")
#'
#' get_prescriptions(start="2015.03.04",end="2015.03.07",optional_ndc_codes = c("00555099702"),
#' columns_to_return = c("enrolid","ndcnum","svcdate"))
#'
#' # extract first svcdate (index date) by patient id (enrolid) from prescription_drug table
#' # between svcdates 2015.03.04 and 2015.03.07 for ndcnum (NDC) code c("00555099702")
#'
#' get_patient_id_prescriptions(start="2015.03.04",end="2015.03.07",optional_ndc_codes =
#' c("00555099702"))

get_prescriptions <- function(optional_q_table_name="prescription_drug",columns_to_return,start,end,
  optional_ndc_codes="__NULL__",optional_enrolids="__NULL__",api_function="get_prescriptions",return_all_flag=F,...){

  paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
                        columns_to_return=columns_to_return,optional_ndc_codes=optional_ndc_codes,
                        start=start,end=end,optional_enrolids=optional_enrolids,
                        return_all_flag=return_all_flag,...)

  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult
}

#' @rdname get_prescriptions
#' @export
get_patient_id_prescriptions <- function(optional_q_table_name="prescription_drug",start,end,optional_ndc_codes="__NULL__",optional_enrolid="__NULL__",...){
  get_prescriptions(optional_q_table_name=optional_q_table_name,columns_to_return="__NULL__",start=start,end=end,
                    optional_ndc_codes=optional_ndc_codes,optional_enrolid=optional_enrolid,return_all_flag = T,api_function="get_patient_id_outpatient",...)
}

