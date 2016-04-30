q2d<-function(x){
      x <- gsub("T1", "-01", x)       # map first quarter to January
      x <- gsub("T2", "-04", x)       # map second quarter to April
      x <- gsub("T3", "-07", x)       # map third quarter to July
      x <- gsub("T4", "-10", x)       # map fourth quarter October
      
      x <- paste(x, "-01", sep="")    # add first day of the month
      
      as.Date(x, "%Y-%m-%d")          # convert to date
}