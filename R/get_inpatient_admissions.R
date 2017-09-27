
#' @name get_inpatient_admissions
#' @title extract data from the inpatient admissions table

#' @description The inpatient_admissions family of functions (\code{\link{get_inpatient_admissions}})
#' provides an interface to query the inpatient_admissions table in the Truven Marketscan Health
#' Research Database. The \code{get_inpatient_admissions} function extracts data verbatim from the
#' inpatient_admissions table. The \code{get_patient_id_inpatient_admissions} function extracts the index date
#' (i.e., the first date of service) corresponding to patient ids (generally the 'enrolid') within
#' the given date range and if applicable, optional parameters.
#'
#' @param optional_q_table_name an optional field where the name of the inpatient_admissions table
#' may be passed. The function sets a default table name called "inpatient_admissions" which is used
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
#' @details The inpatient_admissions functions allow the user to retrieve data from the inpatient_admissions
#' table in the Truven Health MarketScan® Research Database.
#'
#' The Inpatient Admissions dataset is part of the Truven Health Marketscan's Commercial Claims & Encounters database
#' and contains claims information for services provided during a hospital admission. The table provides information on
#' treatment during admissions such as diagnosis codes, procedure codes and other variables. It also contains detailed
#' patient-level demographic data such as age, gender, employment-related information and others on a per-record basis.
#'
#' Additional information from Truven: Truven Health constructs this table after identifying all of the encounters or
#' claims (service records) associated with an admission (e.g., hospital claims, physician claims, surgeon claims, and
#' claims from independent laboratories). Facility and professional payment information is then summarized for all
#' services. The summarized information is stored in an admission record in the Inpatient Admissions Table.
#'
#' The admission record also includes data that can only be identified after all claims for an admission have been
#' identified.  These additional data include the principal procedure, principal diagnosis, major diagnostic category
#' (MDC), and diagnosis-related group (DRG). Truven Health uses the Centers for Medicare & Medicaid Services (CMS) DRG
#' Grouper to assign an MDC and DRG to the admission record. In addition to the principal procedure and diagnosis codes, the
#' admission record includes all diagnoses and procedures (up to 14 each) found on the service records that make up
#' the admission. These additional codes (Diagnosis 2 through Diagnosis 15 and Procedure 2 through Procedure 15) are
#' assigned chronologically based on service dates and do not duplicate the principal code. To be considered an admission,
#' the grouping of these service records must meet certain criteria (e.g., a room and board claim must be present).
#' If these criteria are not met, the records are stored in the Outpatient Services Table (O) and no admission record
#' is created.
#'
#'
#' @return A data.table with the results of the query
#'
#' @export
#' @examples
#'
#' # extract data from inpatient_admissions table
#'
#' # extract dstatus, patflag, enrolid, admdate and proc1 from inpatient_admissions between
#' # svcdates 2009.03.20 and 2009.04.20 for diagnosis (dx) codes c("78650","7384"), procedure
#' # (proc1) codes c("8856","3971") and do not filter on optional_enrolids (set to __NULL__
#' # is the same as not setting it at all in a function. Here it is shown with the
#' # parameter set to __NULL)
#'
#' get_inpatient_admissions(columns_to_return=c("dstatus","patflag","enrolid","admdate","proc1"),
#' start="2009.03.20",end="2009.04.20",optional_diag_codes=c("78650","7384"),optional_proc_codes=
#' c("8856","3971"), optional_enrolids="__NULL__", return_all_flag = F,get_stats="TRUE")
#'
#' # extract first svcdate (the indexdate) from inpatient_admissions for all patients between
#' # 2009.03.20 and 2009.07.20 with diagnosis (dx) codes c("78650","7384") and procedure (proc1)
#' # codes of c("8856","3971")
#'
#' get_patient_id_inpatient_admissions(start="2009.03.20",end="2009.07.20",optional_diag_codes=
#' c("78650","7384"), optional_proc_codes=c("8856","3971"),get_stats="TRUE")
#
get_inpatient_admissions <- function(optional_q_table_name="inpatient_admissions",columns_to_return,start,end,optional_diag_codes="__NULL__",
  optional_proc_codes="__NULL__",optional_enrolids="__NULL__",api_function="get_inpatient_admissions",return_all_flag = F,...){

  paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
                        columns_to_return=columns_to_return,optional_diag_codes=optional_diag_codes,optional_proc_codes=optional_proc_codes,
                        start=start,end=end,optional_enrolids=optional_enrolids,
                        return_all_flag=return_all_flag,...)

  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}

#' @rdname get_inpatient_admissions
#' @export
get_patient_id_inpatient_admissions <- function(optional_q_table_name="inpatient_admissions",start,end,optional_diag_codes="__NULL__",optional_proc_codes="__NULL__",optional_enrolids="__NULL__",...){
  get_inpatient_admissions(optional_q_table_name=optional_q_table_name,columns_to_return="__NULL__",start=start,end=end,optional_diag_codes=optional_diag_codes,
                           optional_proc_codes=optional_proc_codes,optional_enrolids=optional_enrolids,return_all_flag = T,api_function="get_patient_id_inpatient_admissions",...)
}
