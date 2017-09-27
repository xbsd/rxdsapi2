#' @name q_utilities
#' @title functions that interact directly with the KDB+ processes supporting the database
#'
#' @description The \code{q_set_operation} function performs a set operation on a list of vectors. The
#' supported operations are: union, intersection and complement (minus). These operations are executed
#' in an incremental manner across the list of vectors in the function
#' API calls.
#'
#' @param list_of_q_vectors a list containing vectors on which the operation should be performed
#' @param set_operation a character value indicating the type of set operation requested. Allowed values are:
#' "union","intersection" and "complement"
#'
#' @param return_all_flag a boolean value indicating whether all the data should be returned to R.
#' This parameter generally defaults to FALSE since returning large amounts of data to the R Session
#' may take time. It should be set to TRUE only if you are certain that you'd like to load all the
#' data that is a result of the query into your session.
#'
#' @param api_function a variable indicating the name of the function. It is unlikely that you'll ever
#' need to change the value of this parameter and it is best left as-is
#'
#' @return q_set_operation: a data table with the results of the query
#' @export
#' @examples
#'
#' # union of c(1,2,3) and c(3,4,5)
#' q_set_operation(list(c(1,2,3),c(3,4,5)), set_operation = "union")
#'
#' # intersection of c(1,2,3) and c(3,4,5)
#' q_set_operation(list(c(1,2,3),c(3,4,5)), set_operation = "intersection")
#'
#' # complement of c(1,2,3) and c(3,4,5)
#' q_set_operation(list(c(1,2,3),c(3,4,5)), set_operation = "complement")
q_set_operation <- function(list_of_q_vectors="__NULL__", set_operation="__NULL__",api_function="q_set_operation",return_all_flag=F,...){

  ifelse(any(identical(list_of_q_vectors,"__NULL__"),identical(set_operation,"__NULL")), return (list_of_q_vectors),"")
  paramList     <- list(list_of_q_vectors=list_of_q_vectors,set_operation=set_operation,api_function=api_function,return_all_flag=return_all_flag,...)

  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}

#' @description The \code{get_q_object} returns a Q object from the KDB+ server
#'
#' @param q_object_name the name of the Q object
#' @return get_q_object: a data table with the values of the Q object
#' @rdname q_utilities
#' @export
#' @examples
#'
#' # get the JSON object APP_QUERY in the KDB+ server
#' get_q_object("APP_QUERY")
get_q_object <- function(q_object_name,api_function="get_q_object",return_all_flag=F,...){
  paramList     <- list(q_object_name=q_object_name,return_all_flag=return_all_flag,api_function=api_function,...)
  queryResult   <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult

}

#' @description The \code{get_q_table} returns a Q table from the KDB+ server
#'
#' @param q_table_name the name of the Q table
#' @return get_q_table: a data table with the values of the Q object
#' @rdname q_utilities
#' @export
#' @examples
#'
#' # get the Q table dim_cap from the KDB+ server
#' get_q_table("dim_cap")
get_q_table <- function(q_table_name, return_all_flag=F,api_function="get_q_table",...){
  get_q_object(q_object_name=q_table_name,return_all_flag=return_all_flag,api_function="get_q_table",...)

}
