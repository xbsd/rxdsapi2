# .onAttach <- function(libname, pkgname) {
#   # Runs when attached to search() path such as by library() or require()
#   if (interactive()) {
#     v = packageVersion("rxdsapi")
#     d = read.dcf(system.file("DESCRIPTION", package="rxdsapi"), fields = c("Packaged", "Built"))
#     if(is.na(d[1])){
#       if(is.na(d[2])){
#         return() #neither field exists
#       } else{
#         d = unlist(strsplit(d[2], split="; "))[3]
#       }
#     } else {
#       d = d[1]
#     }
#     packageStartupMessage('This is the RXDS KDB+ API for connecting to Pharmaceutical datasets from R')
#     packageStartupMessage('The package imports a few libraries from CRAN as well as the rkdb package from github')
#     packageStartupMessage('For this, you may need to install devtools (sudo apt-get install libssl-dev libcurl4-openssl-dev)')
#     packageStartupMessage('Most users will not require the above step of installing libssl, but it has been provided for reference')
#     packageStartupMessage("rxdsapi ", v, d)
#   }
# }
