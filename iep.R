#
# Índices de entradas de pedidos corregidos de efectos estacionales y de calendario (Base 2010)
#

require(pxR, quietly = TRUE)
require(dplyr, quietly = TRUE)
require(zoo, quietly = TRUE)
require(ggplot2, quietly = TRUE)

url.ine<-'http://www.ine.es/jaxiT3/files/t/es/px/3402.px?nocab=1'

file.name<-basename(url.ine)
file.name<-strsplit(file.name, '[?]')[[1]][1]

download.file(url.ine, destfile = file.name, method = "auto")

tpx<-read.px("3402.px")
tdf<-as.data.frame(tpx)
tdf<-tdf %>% mutate(Periodo=as.yearmon(Periodo, "%YM%m"))
saveRDS(tdf, 'iep.RDS', compress = TRUE)

lista.Destinos<-tpx$VALUES$Destino.económico.de.los.bienes[c(1,2,3,9,20,24,28,34,41,44)]
Indice<-tpx$VALUES$Índice.y.tasas[1]
ggtdf<-tdf %>% filter(Índice.y.tasas == Indice & !is.na(value) & Destino.económico.de.los.bienes %in% lista.Destinos)

g<-ggplot(ggtdf, aes(x=Periodo, y=value))
g<-g + geom_line()
g<-g + facet_wrap(~ Destino.económico.de.los.bienes, scales = 'free_y', ncol = 2)
g<-g + geom_hline(yintercept = 0)
g<-g + scale_x_yearmon()
g<-g + ggtitle(paste(tpx$SUBJECT.AREA, "\n",tpx$TITLE))
g<-g + ylab(Indice)
g

