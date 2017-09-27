
# KDB API v4 - Moved to Q

# Package Check
# required_packages <- c("bit64","lubridate","jsonlite","data.table","devtools")
# missing_packages  <- required_packages[which(!required_packages %in% rownames(installed.packages()))]
# if(length(missing_packages)>0) install.packages(missing_packages,repos='http://cran.us.r-project.org')
# if(!'rkdb' %in% rownames(installed.packages())){devtools::install_github('kxsystems/rkdb', quiet=TRUE)}

# Load Libraries
library(rkdb)
library(bit64)
library(lubridate)
library(jsonlite)
library(data.table)

# test_connection <- function() {
#   ifelse("sanofi_api_r_kdb_server" %in% ls(envir = .GlobalEnv),paste0("Using RXDS Server:",sanofi_api_r_kdb_server),sanofi_api_r_kdb_server <<- readline(prompt="Enter Target RXDS Servername: "))
#   ifelse("sanofi_api_r_kdb_port" %in% ls(envir = .GlobalEnv),paste0("Using RXDS Port:  ",sanofi_api_r_kdb_port),sanofi_api_r_kdb_port <<- as.integer(readline(prompt="Enter Target RXDS Port: ")))
#   cat ("\nChecking connectivity to Sanofi RXDS R Server ...\n")
#   connection <- tryCatch({connInfo <- open_connection(sanofi_api_r_kdb_server,sanofi_api_r_kdb_port)}, error = function(e){"Error"})
#   cond <- identical(connection,"Error")
#   cat(ifelse(cond,paste0("Failed to connect to Sanofi RXDS R Server, please try again after some time, run reset_connection() or contact support if the issue persists\n\n"),
#              paste0("Successfully connected to Sanofi RXDS R Server: ",sanofi_api_r_kdb_server," | Port: ",sanofi_api_r_kdb_port,"\n\n")))
#   if(!cond) close_connection(connection)
#   list(sanofi_api_r_kdb_server=sanofi_api_r_kdb_server,sanofi_api_r_kdb_port=sanofi_api_r_kdb_port,connection=connection,cond=cond)
# }
#
# reset_connection <- function(){
#   if("sanofi_api_r_kdb_server" %in% ls(envir = .GlobalEnv)) rm(sanofi_api_r_kdb_server,envir = .GlobalEnv)
#   if("sanofi_api_r_kdb_port" %in% ls(envir = .GlobalEnv)) {rm(sanofi_api_r_kdb_port,envir = .GlobalEnv)}
#
# }
#
# get_table_stats <- function(RStats,kdbStats,startTime,endTime){
#   RStats$R_START <- format(startTime,"%H:%M:%S")
#   RStats$R_END   <- format(endTime,"%H:%M:%S")
#   RStats$R_DURATION <- round(endTime - startTime,3)
#   cbind(RStats,kdbStats)
# }

# process_query <- function(api_function,get_stats="FALSE",...){
#   startTime  <- Sys.time()
#   queryText   <- URLencode(as.character(toJSON(list(...),force=TRUE)))
#   print (queryText)
#   connTest    <- test_connection()
#   if(connTest$cond==TRUE) {reset_connection(); cat("Please rerun previous command");return("")}
#   scipen_value <- getOption("scipen")
#   if(!scipen_value==999) options(scipen=999)
#
#   h                      <- open_connection(connTest$sanofi_api_r_kdb_server,connTest$sanofi_api_r_kdb_port) # Change to localhost
#   res                    <- execute(h,api_function,queryText)
#   close_connection(h)
#   options(scipen=scipen_value)
#
#   kdbStats               <- data.table(res$times)
#   tableData              <- data.table(res$res)
#   RStats0                <- tables(silent=TRUE)
#   RStats                 <- RStats0[RStats0$NAME=="tableData",]
#   endTime                <- Sys.time()
#   allStats               <- get_table_stats(RStats,kdbStats,startTime,endTime)
#   if(get_stats=="TRUE") print(allStats)
#   tableData
# }
#
#

# get_patient_id_enrollment <- function(optional_q_table_name="detail_enrollment",start,end,optional_enrolids="__NULL__",return_all_flag=F,  api_function="get_patient_id_enrollment",...){
#
#     paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
# }


# get_outpatient_services <- function(optional_q_table_name="outpatient_services",columns_to_return,
#                                     start,end,optional_diag_codes="__NULL__",optional_enrolids="__NULL__",return_all_flag=F,api_function="get_outpatient_services",...){
#
#   paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
#                         columns_to_return=columns_to_return,optional_diag_codes=optional_diag_codes,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
# }
#
# get_patient_id_outpatient <- function(optional_q_table_name="outpatient_services",start,end,optional_diag_codes="__NULL__",
#                                       optional_enrolids="__NULL__",return_all_flag=F,api_function="get_patient_id_outpatient",...){
#   get_outpatient_services(optional_q_table_name=optional_q_table_name,start=start,end=end,columns_to_return="__NULL__",api_function=api_function,
#                           optional_diag_codes=optional_diag_codes,optional_enrolids=optional_enrolids,return_all_flag=T,...)
# }

# get_prescriptions <- function(optional_q_table_name="prescription_drug",columns_to_return,start,end,
#                               optional_ndc_codes="__NULL__",optional_enrolids="__NULL__",return_all_flag=F,api_function="get_prescriptions",...){
#
#   paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
#                         columns_to_return=columns_to_return,optional_ndc_codes=optional_ndc_codes,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
# }
#
# get_patient_id_prescriptions <- function(optional_q_table_name="prescription_drug",start,end,optional_ndc_codes="__NULL__",optional_enrolid="__NULL__",...){
#   get_prescriptions(optional_q_table_name=optional_q_table_name,columns_to_return="__NULL__",start=start,end=end,
#                     optional_ndc_codes=optional_ndc_codes,optional_enrolid=optional_enrolid,return_all_flag = T,api_function="get_patient_id_outpatient",...)
# }
#
# get_inpatient_services <- function(optional_q_table_name="inpatient_services",columns_to_return,start,end,optional_diag_codes="__NULL__",
#                                    api_function="get_inpatient_services",optional_proc_codes="__NULL__",optional_enrolids="__NULL__", return_all_flag=F,...){
#
#   paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
#                         columns_to_return=columns_to_return,optional_diag_codes=optional_diag_codes,optional_proc_codes=optional_proc_codes,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
# }
#
# get_patient_id_inpatient <- function(optional_q_table_name="inpatient_services",start,end,optional_ndc_codes="__NULL__",optional_diag_codes="__NULL__",
#                                               optional_proc_codes="__NULL__",optional_enrolids="__NULL__",...){
#   get_inpatient_services(optional_q_table_name=optional_q_table_name,columns_to_return="__NULL__",start=start,end=end,optional_diag_codes=optional_diag_codes,
#                     optional_proc_codes=optional_proc_codes,optional_enrolids=optional_enrolids,return_all_flag = T,api_function="get_patient_id_inpatient",...)
# }
#

# get_inpatient_admissions <- function(optional_q_table_name="inpatient_admissions",columns_to_return,start,end,optional_diag_codes="__NULL__",
#                                      optional_proc_codes="__NULL__",optional_enrolids="__NULL__", api_function="get_inpatient_admissions",return_all_flag = F,...){
#
#   paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,
#                         columns_to_return=columns_to_return,optional_diag_codes=optional_diag_codes,optional_proc_codes=optional_proc_codes,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
#   }
#
# get_patient_id_inpatient_admissions <- function(optional_q_table_name="inpatient_admissions",start,end,optional_diag_codes="__NULL__",optional_proc_codes="__NULL__",optional_enrolids="__NULL__",...){
#
#   get_inpatient_admissions(optional_q_table_name=optional_q_table_name,columns_to_return="__NULL__",start=start,end=end,optional_diag_codes=optional_diag_codes,
#                          optional_proc_codes=optional_proc_codes,optional_enrolids=optional_enrolids,return_all_flag = T,api_function="get_patient_id_inpatient_admissions",...)
#
# }

# get_lab_data <- function(optional_q_table_name="lab_test_results",columns_to_return,start,end,optional_lab_codes="__NULL__",optional_abnormal="__NULL__",optional_enrolids="__NULL__",return_all_flag=F,api_function="get_lab_data",...){
#
#   paramList     <- list(optional_q_table_name=optional_q_table_name,api_function=api_function,columns_to_return=columns_to_return,
#                         optional_lab_codes=optional_lab_codes,optional_abnormal=optional_abnormal,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
#   }
#
#
# get_patient_id_labs <- function(optional_q_table_name="lab_test_results",start,end,optional_lab_codes="__NULL__",optional_abnormal="__NULL__",optional_enrolids="__NULL__",return_all_flag=F,...){
#
#   get_lab_data(optional_q_table_name=optional_q_table_name,api_function="get_patient_id_labs",columns_to_return="__NULL__",
#                         optional_lab_codes=optional_lab_codes,optional_abnormal=optional_abnormal,
#                         start=start,end=end,optional_enrolids=optional_enrolids,
#                         return_all_flag=return_all_flag,...)
#
#   }
#

# q_set_operation <- function(list_of_q_vectors="__NULL__", set_operation="__NULL__",api_function="q_set_operation",return_all_flag=F,...){
#
#   ifelse(any(identical(list_of_q_vectors,"__NULL__"),identical(set_operation,"__NULL")), return (list_of_q_vectors),"")
#   paramList     <- list(list_of_q_vectors=list_of_q_vectors,set_operation=set_operation,return_all_flag=return_all_flag,...)
#
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
#   }

get_diag_codes <- function(diag_codes="__NULL__",api_function="get_diag_codes",...){
  paramList     <- list(diag_codes=diag_codes,api_function=api_function,...)
  queryResult <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult$V1
}


# get_q_object <- function(q_object_name, return_all_flag=F,api_function="get_q_object",...){
#   paramList     <- list(q_object_name=q_object_name,return_all_flag=return_all_flag,api_function=api_function,...)
#   queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
#   queryResult
#
# }
#
# get_q_table <- function(q_table_name, return_all_flag=F,api_function="get_q_table",...){
#   get_q_object(q_object_name=q_table_name,return_all_flag=return_all_flag,api_function="get_q_table",...)
#
# }

#
# get_patient_id_enrollment(start="2009.01.01",end="2009.03.01",get_stats="TRUE") # Takes a bit of time as it is running an aggregation across 37M unique ids
#
# get_patient_id_enrollment(start="2010.01.01",end="2010.06.01",optional_enrolids=c(8929201,53402,902),get_stats="TRUE")
#
# get_outpatient_services(columns_to_return=c("age","month"),start="2015.03.04",end="2015.03.07",optional_diag_codes=c("32723","4439"),
#                           optional_enrolids=c(8601,12901),return_all_flag=F,get_stats="TRUE")
#
# get_patient_id_outpatient(start="2015.03.04",end="2015.03.07",optional_diag_codes=c("32723","4439"),optional_enrolids=c(8601,12901),return_all_flag=F,get_stats="TRUE")
#
# get_prescriptions(start="2015.03.04",end="2015.03.07",optional_ndc_codes = c("00555099702"),columns_to_return = c("enrolid","ndcnum","svcdate"))
#
# get_patient_id_prescriptions(start="2015.03.04",end="2015.03.07",optional_ndc_codes = c("00555099702"))
#
# get_inpatient_services(columns_to_return=c("age","enrolid","svcdate"),start="2009.12.01",end="2009.12.01",optional_diag_codes="2724",optional_proc_codes="J2930",optional_enrolids=2560802, return_all_flag=F,get_stats="TRUE")
#
# get_patient_id_inpatient(start="2009.12.01",end="2009.12.01",optional_diag_codes="2724",optional_proc_codes="J2930",optional_enrolids=2560802, get_stats="TRUE")
#
# get_patient_id_inpatient(optional_q_table_name="inpatient_services",start="2015.02.03",end="2016.03.04", optional_diag_codes="2724",get_stats="TRUE")
#
# get_inpatient_admissions(columns_to_return=c("dstatus","patflag","enrolid","admdate","proc1"),start="2009.03.20",end="2009.04.20",optional_diag_codes=c("78650","7384"),optional_proc_codes=c("8856","3971"),optional_enrolids="__NULL__", return_all_flag = F,get_stats="TRUE")
#
# get_inpatient_admissions(columns_to_return=c("dstatus","patflag","dx1","admdate","proc1"),start="2009.03.20",end="2009.04.20",optional_diag_codes=c("78650","7384"),optional_proc_codes=c("8856","3971"),optional_enrolids="__NULL__", return_all_flag = T,get_stats="TRUE")
#
# get_patient_id_inpatient_admissions(start="2009.03.20",end="2009.07.20",optional_diag_codes=c("78650","7384"),optional_proc_codes=c("8856","3971"),get_stats="TRUE")
#
# get_lab_data(columns_to_return=c("enrolid","svcdate","loinccd"),start="2008.01.01",end="2008.04.01",optional_lab_codes="2085-9",optional_enrolid=474702,return_all_flag=F,get_stats="TRUE")
#
# get_patient_id_labs(start="2008.01.01",end="2008.04.01",optional_lab_codes="2085-9",return_all_flag=F,get_stats="TRUE")
#
# get_q_object("inpatient_admissions")
#
# get_q_table("inpatient_admissions")
#
