#' @name process_query
#' @title a wrapper (function) to execute an API function
#'
#' @description The \code{process_query} function processes parameters passed by any of the API function
#' by converting them first to JSON format and then normalising the string with an URLencode command.
#' It is not intended to be run directly by the end user and is instead used by the package to wrap
#' API calls.
#'
#' @param api_function a character value with the name of the api function
#' @param get_stats a boolean variable indicating whether query statistics should be printed
#'
#' @return a data table with the results of the query
#' @rdname process_query
#' @export
process_query <- function(api_function,get_stats="FALSE",...){
  startTime  <- Sys.time()
  queryText   <- URLencode(as.character(jsonlite::toJSON(list(...),force=TRUE)))
  print (queryText)
  connTest    <- test_connection()
  if(connTest$cond==TRUE) {reset_connection(); cat("Please rerun previous command");return("")}
  scipen_value <- getOption("scipen")
  if(!scipen_value==999) options(scipen=999)

  h                      <- open_connection(connTest$rxds_api_r_kdb_server,connTest$rxds_api_r_kdb_port) # Change to localhost
  res                    <- execute(h,api_function,queryText)
  close_connection(h)
  options(scipen=scipen_value)

  kdbStats               <- data.table(res$times)
  tableData              <- data.table(res$res)
  RStats0                <- tables(silent=TRUE)
  RStats                 <- RStats0[RStats0$NAME=="tableData",]
  endTime                <- Sys.time()
  allStats               <- get_table_stats(RStats,kdbStats,startTime,endTime)
  if(get_stats=="TRUE") print(allStats)
  tableData
}

