#' @name get_diag_codes
#' @title retrieves diagnosis (dx) codes matching a wildchar
#'
#' @description The \code{get_diag_codes} function processes extracts diagnosis codes from
#' the dim_dx table matching the pattern passed in the function
#'
#' @param diag_codes a string with the requested pattern for diagnosis code
#' @param api_function a variable indicating the name of the function. It is unlikely that you'll ever
#' need to change the value of this parameter and it is best left as-is
#'
#' @return a vector with the diagnosis codes
#' @rdname get_diag_codes
#' @export
#' @examples
#'
#' # extract diagnosis codes starting with E11
#' get_diag_codes("E11*")
get_diag_codes <- function(diag_codes="__NULL__",api_function="get_diag_codes",...){
  paramList     <- list(diag_codes=diag_codes,api_function=api_function,...)
  queryResult <- process_query(api_function=api_function,queryArgs=paramList,...)
  queryResult$V1
}
