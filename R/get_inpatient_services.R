#' @name get_inpatient_services
#' @title extract data from the inpatient services table

#' @description The inpatient_services family of functions (\code{\link{get_inpatient_services}})
#' provides an interface to query the inpatient_services table in the Truven Marketscan Health
#' Research Database. The \code{get_inpatient_services} function extracts data verbatim from the
#' inpatient_servives table. The \code{get_patient_id_inpatient} function extracts the index date
#' (i.e., the first date of service) corresponding to patient ids (generally the 'enrolid') within
#' the given date range and if applicable, optional parameters
#'
#' @param optional_q_table_name an optional field where the name of the inpatient_services table
#' may be passed. The function sets a default table name called "inpatient_services" which is used
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
#' @param optional_diag_codes a character vector of dx (diagnosis) codes
#'
#' @param optional_proc_codes a character vector of proc1 (procedure) codes
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
#' @details The inpatient_services functions allow the user to retrieve data from the inpatient_services
#' table in the Truven Health MarketScan® Research Database.
#'
#' The Inpatient Services dataset is part of the Truven Health Marketscan's Commercial Claims & Encounters database
#' and contains claims information for services provided during inpatient services (such as during a hospital stay).
#' The table provides detailed information on post-admission treatment such as diagnosis codes, co-insurance amounts
#' and other variables. It also contains detailed patient-level demographic data such as age, gender, employment-related
#' information and others on a per-record basis.
#'
#' Additional information from Truven: A Cases and Services Link (CASEID) identifier exists on both the
#' Inpatient Admissions and the Inpatient Services Tables to identify the individual service
#' records that each admission record comprises. Facility inpatient service records are derived
#' from the Uniform Billing (UB04) form. This form does not link financial information to specific procedures or
#' diagnoses. Physician services are derived from the Centers for Medicare & Medicaid Services (CMS) 1500 form.
#'
#' Note: The Inpatient Services Table contains both facility and physician services associated with an inpatient admission.
#' The Inpatient Admissions Table differs from UB04 discharge data in that Truven Health combines the facility charges
#' with the physician services associated with an inpatient admission. UB04 revenue codes are retained in the MarketScan
#' data when available; however, not all data contributors provide the codes on adjudicated claims.

#'
#' @return A data.table with the results of the query
#'
#' @export
#' @examples
#'
#' # extract data from inpatient_services table
#'
#' # extract age, enrolid and svcdate from inpatient_services between svcdates 2009.12.01 and
#' # 2009.12.01 for diagnosis (dx) code "2724", procedure (proc1) code "J2930, enrolid 2560802
#'
#' get_inpatient_services(columns_to_return=c("age","enrolid","svcdate"),start="2009.12.01",
#' end="2009.12.01", optional_diag_codes="2724",optional_proc_codes="J2930",optional_enrolids=
#' 2560802, return_all_flag=F,get_stats="TRUE")
#'
#' # extract first svcdate by patient id from inpatient_services between svcdates 2009.12.01 and
#' # 2009.12.01 for diagnosis (dx) code "2724", procedure (proc1) code "J2930, enrolid 2560802
#'
#' get_patient_id_inpatient(start="2009.12.01",end="2009.12.01",optional_diag_codes="2724",
#' optional_proc_codes="J2930", optional_enrolids=2560802, get_stats="TRUE")
#'
#' # extract first svcdate by patient id from inpatient_services between svcdates 2015.02.03 and
#' # 2016.03.04 for diagnosis (dx) code "2724"
#'
#' get_patient_id_inpatient(optional_q_table_name="inpatient_services",start="2015.02.03",
#' end="2016.03.04", optional_diag_codes="2724",get_stats="TRUE")
get_inpatient_services <- function(optional_q_table_name="inpatient_services",columns_to_return,start,end,optional_diag_codes="__NULL__",optional_proc_codes="__NULL__",optional_enrolids="__NULL__", return_all_flag=F,api_function="get_inpatient_services",...){

  paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
                        columns_to_return=columns_to_return,optional_diag_codes=optional_diag_codes,optional_proc_codes=optional_proc_codes,
                        start=start,end=end,optional_enrolids=optional_enrolids,
                        return_all_flag=return_all_flag,...)

  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}


#' @rdname get_inpatient_services
#' @export
get_patient_id_inpatient <- get_patient_id_inpatient <- function(optional_q_table_name="inpatient_services",start,end,optional_ndc_codes="__NULL__",optional_diag_codes="__NULL__",optional_proc_codes="__NULL__",optional_enrolids="__NULL__",...)
{
  get_inpatient_services(optional_q_table_name=optional_q_table_name,columns_to_return="__NULL__",start=start,end=end,optional_diag_codes=optional_diag_codes,optional_proc_codes=optional_proc_codes,optional_enrolids=optional_enrolids,return_all_flag = T,api_function="get_patient_id_inpatient",...)
}

