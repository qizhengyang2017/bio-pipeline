```R
function (test, yes, no) 
{
    if (is.atomic(test)) {
        if (typeof(test) != "logical") 
            storage.mode(test) <- "logical"
        if (length(test) == 1 && is.null(attributes(test))) {
            if (is.na(test)) 
                return(NA)
            else if (test) {
                if (length(yes) == 1) {
                  yat <- attributes(yes)
                  if (is.null(yat) || (is.function(yes) && identical(names(yat), 
                    "srcref"))) 
                    return(yes)
                }
            }
            else if (length(no) == 1) {
                nat <- attributes(no)
                if (is.null(nat) || (is.function(no) && identical(names(nat), 
                  "srcref"))) 
                  return(no)
            }
        }
    }
    else test <- if (isS4(test)) 
        methods::as(test, "logical")
    else as.logical(test)
    ans <- test
    len <- length(ans)
    ypos <- which(test)
    npos <- which(!test)
    if (length(ypos) > 0L) 
        ans[ypos] <- rep(yes, length.out = len)[ypos]
    if (length(npos) > 0L) 
        ans[npos] <- rep(no, length.out = len)[npos]
    ans
}
```
