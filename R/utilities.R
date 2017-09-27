#' @name utilities
#' @title helper utilities for the RXDS API for Truven Health Research Database

#' @description The \code{test_connection} function initiates a connection to a target R Server
#' using the servername and port number. The user simply needs to execute the function
#' \code{test_connection()} which will prompt for the server and port information. The function
#' then attempts to establish a connection. The user will get a message confirming whether the
#' connection was successful or otherwise.
#'
#' Important: The user should never have to run this function except for debugging purposes. Each
#' function in the API automatically executes this function to test for connectivity. It is intended
#' to merely indicate the existence of a valid server:port connection.
#'
#' When this function is executed successfully, it sets 2 global variables:
#' rxds_api_r_kdb_server: The server name; and
#' rxds_api_r_kdb_port: The port number of the server
#'
#' In the event that the connection is not successful, the user may re-execute the function or
#' contact support for further information.
#'
#' This function does not accept any parameter.
#'
#' @return A message confirming the status of the connection attempt
#'
#' @export
#' @examples
#'
test_connection <- function() {
  ifelse("rxds_api_r_kdb_server" %in% ls(envir = .GlobalEnv),paste0("Using RXDS Server:",rxds_api_r_kdb_server),rxds_api_r_kdb_server <<- readline(prompt="Enter Target RXDS Servername: "))
  ifelse("rxds_api_r_kdb_port" %in% ls(envir = .GlobalEnv),paste0("Using RXDS Port:  ",rxds_api_r_kdb_port),rxds_api_r_kdb_port <<- as.integer(readline(prompt="Enter Target RXDS Port: ")))
  cat ("\nChecking connectivity to KDB+ Server ...\n")
  connection <- tryCatch({connInfo <- open_connection(rxds_api_r_kdb_server,rxds_api_r_kdb_port)}, error = function(e){"Error"})
  cond <- identical(connection,"Error")
  cat(ifelse(cond,paste0("Failed to connect to KDB+ Server, please try again after some time, run reset_connection() or contact support if the issue persists\n\n"),
             paste0("Successfully connected to KDB+ Server: ",rxds_api_r_kdb_server," | Port: ",rxds_api_r_kdb_port,"\n\n")))
  if(!cond) close_connection(connection)
  list(rxds_api_r_kdb_server=rxds_api_r_kdb_server,rxds_api_r_kdb_port=rxds_api_r_kdb_port,connection=connection,cond=cond)
}

#' @description The \code{reset_connection} function resets connection details for a target R server.
#' When a connection to a target server is established, the system sets 2 global variables (rxds_api_r_kdb_server
#' and rxds_api_r_kdb_port). This function resets the value of the variables and when the user
#' attempts to run a new function, it prompts the user for the relevant server/port information
#'
#' In the event that the connection is not successful, the user may re-execute the function or
#' contact support for further information.
#'
#' This function does not accept any parameter.
#'
#' @return None
#' @rdname utilities
#' @export
reset_connection <- function(){
  if("rxds_api_r_kdb_server" %in% ls(envir = .GlobalEnv)) rm(rxds_api_r_kdb_server,envir = .GlobalEnv)
  if("rxds_api_r_kdb_port" %in% ls(envir = .GlobalEnv)) {rm(rxds_api_r_kdb_port,envir = .GlobalEnv)}

}

#' @description The \code{get_table_stats} combines data from R and KDB+ execution statistics
#' This is a 'helper' function for other functions in the package and is not intended to be execute
#' directly by the end user
#'
#' @param RStats a data table with R connection statistics
#' @param kdbStats a data table with KDB+ connection statistics
#' @param startTime a character value with start time
#' @param endTime a character value with end time

#' @return a data table with R Stats and KDB+ Stats
#' @rdname utilities
#' @export
get_table_stats <- function(RStats,kdbStats,startTime,endTime){
  RStats$R_START <- format(startTime,"%H:%M:%S")
  RStats$R_END   <- format(endTime,"%H:%M:%S")
  RStats$R_DURATION <- round(endTime - startTime,3)
  cbind(RStats,kdbStats)
}

