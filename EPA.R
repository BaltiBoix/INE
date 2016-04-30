require(pxR, quietly = TRUE)
require(dplyr, quietly = TRUE)
require(ggplot2, quietly = TRUE)
source('~/RProjects/INE/q2d.R')

#  EPA
#
#  Población de 16 y más años por relación con la actividad económica,sexo y provincia: 3988
download.file("http://www.ine.es/jaxiT3/files/t/es/px/3988.px?nocab=1", destfile = "tabla_3988.px", method = "auto")
tpx_3988<-read.px("tabla_3988.px")
tdf_3988<-as.data.frame(tpx_3988)

# Población de 16 y más años por nivel de formación alcanzado, sexo y comunidad autónoma. Valores absolutos: 4194
download.file("http://www.ine.es/jaxiT3/files/t/es/px/4194.px?nocab=1", destfile = "tabla_4194.px", method = "wininet")
tpx_4194<-read.px("tabla_4194.px")
tdf_4194<-as.data.frame(tpx_4194)

names(tdf_4194)[2:3]=c("key1", "key2")
tdf_4194$Periodo <- q2d(tdf_4194$Periodo)

tcatdf<-filter(tdf_4194, Sexo =="Ambos sexos", key1 != "Total")
p<-ggplot(tcatdf, aes(x=Periodo, y=value, color=key1))
p<-p + geom_line(size=1)
p<-p + facet_wrap(~ key2, scales = "free_y")
p<-p + xlab("") + ylab(tpx_4294$UNITS) + ggtitle(as.character(tpx$TITLE))
p<-p + scale_x_date()
p<-p + theme(axis.text.x=element_text(angle=45, hjust=0.001), 
             legend.position="bottom",
             legend.text = element_text(size=5))
print(p)
