
#' @name get_lab_data
#' @title extract data from the lab test table

#' @description The get_prescriptions family of functions (\code{\link{get_lab_data}})
#' provides an interface to query the lab table in the Truven Marketscan Health
#' Research Database. The \code{get_lab_data} function extracts data verbatim from the
#' lab table. The \code{get_patient_id_labs} function extracts the index date
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
#' @param optional_lab_codes a character vector of loinccode (lab) codes
#'
#' @param optional_abnormal a character value for abnormal indication
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
#' @details The \code{get_lab_data} & \code{get_patient_id_labs} functions allow the user to retrieve
#' data from the lab_test_results table in the Truven Health MarketScan® Research Database.
#' The Lab dataset is part of the Truven Health Marketscan's Commercial Claims & Encounters database and contains claims
#' information laboratory tests for patients in the Marketscan database. The table provides information on laboratory
#' tests along with corresponding lab codes. It also contains detailed patient-level demographic data such as age, gender,
#' employment-related information and others on a per-record basis.
#'
#' Additional Information from Truven:
#' The MarketScan Lab Database helps researchers understand:
#' § How well a drug is performing in the real-world clinical setting
#' § Diagnostic test results administered prior to initiation of drug therapy
#' § Laboratory test results as indicators of drug therapy e effectiveness
#' § Frequency of safety monitoring laboratory tests while a patient is on
#' drug therapy
#' § Differences in treatment patterns between patients whose disease is under
#' control versus not under control

#' The MarketScan Lab Database contains the pooled healthcare experience of over 1 million covered lives, gleaned from
#' sources that include both commercial and Medicare Supplemental coverage. It captures laboratory tests for a subset
#' of the covered lives and mainly represents lab tests ordered in office-based practice. Linkage of lab results to
#' claims supports analyses that are not feasible with claims alone, such as determining effectiveness of treatment,
#' measuring severity of illness, identifying patients for whom treatment may be indicated, and verifying diagnoses
#' recorded on claims.
#'
#' @return A data.table with the results of the query
#'
#' @export
#' @examples
#'
#' # extract data from prescriptions table
#'
#' # extract enrolid, svcdate and loinccd (lab code) from prescription drug table between svcdates 2008.01.01 and
#' # 2008.04.01 for loinccd (Lab) code "2085-9" and enrolid 474702
#'
#' get_lab_data(columns_to_return=c("enrolid","svcdate","loinccd"),start="2008.01.01",end="2008.04.01",
#' optional_lab_codes="2085-9",optional_enrolid=474702,return_all_flag=F,get_stats="TRUE")
#'
#' # extract first svcdate (indexdate) for all patients between svcdates 2008.01.01 and 2008.04.01 for
#' # lab code "2085-9"
#' get_patient_id_labs(start="2008.01.01",end="2008.04.01",optional_lab_codes="2085-9",return_all_flag=F,get_stats="TRUE")
get_lab_data <- function(optional_q_table_name="lab_test_results",columns_to_return,start,end,optional_lab_codes="__NULL__",
                         optional_abnormal="__NULL__",optional_enrolids="__NULL__",api_function="get_lab_data",return_all_flag=F,...){

  paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,columns_to_return=columns_to_return,
                        optional_lab_codes=optional_lab_codes,optional_abnormal=optional_abnormal,
                        start=start,end=end,optional_enrolids=optional_enrolids,
                        return_all_flag=return_all_flag,...)

  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}

#' @rdname get_lab_data
#' @export
get_patient_id_labs <- function(optional_q_table_name="lab_test_results",start,end,optional_lab_codes="__NULL__",optional_abnormal="__NULL__",optional_enrolids="__NULL__",return_all_flag=F,...){

  get_lab_data(optional_q_table_name=optional_q_table_name,api_function="get_patient_id_labs",columns_to_return="__NULL__",
               optional_lab_codes=optional_lab_codes,optional_abnormal=optional_abnormal,
               start=start,end=end,optional_enrolids=optional_enrolids,
               return_all_flag=return_all_flag,...)

}

