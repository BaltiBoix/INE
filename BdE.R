require(dplyr)
require(zoo)

url<-'http://www.bde.es/webbde/es/estadis/infoest/series/ie.zip'
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./dataset")

catalog<-read.csv('dataset/catalogo_ie.csv', header=TRUE, stringsAsFactors = FALSE)

ie0101<-read.csv('dataset/ie0101.csv', header=TRUE, stringsAsFactors = FALSE)

pib<- ie0101 %>% slice(4:NROW(.)) %>% select(fecha=X, pib=IE_1_1.2) %>% mutate(fecha=as.yearmon(fecha)) 
