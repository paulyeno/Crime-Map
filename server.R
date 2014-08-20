library(shiny);library(plyr);library(rCharts)
#data from data.police.uk for City of London Police for June 2014
data<-read.csv("2014-06-city-of-london-street.csv")[,c(5:6,10:11)]
addy<-NULL
for(i in 1:nrow(data)){addy[i]<-paste(data[i,1],data[i,2])}
data<-cbind(data,addy)
rm(addy)
shinyServer(function(input,output){
  output$DotMap<-renderMap({
    dt<-subset(data,Crime.type==input$type,
      select=c("Longitude","Latitude","addy")
    )
    names(dt)<-c("lon","lat","addy")
    dt2<-ddply(dt,.(lat, lon), summarise, count = length(addy))
    alon<-median(dt[,1],na.rm=T)
    alat<-median(dt[,2],na.rm=T)
    dt<-dt2
    dt<-toJSONArray2(na.omit(dt), json = F, names = F)
    DotMap<-Leaflet$new()
    DotMap$setView(c(alat,alon), 14)
    DotMap$tileLayer(provider = "OpenStreetMap")
    for(i in 1:nrow(dt2)){
      DotMap$marker(c(dt2[i,1],dt2[i,2]),
        bindPopup=paste(dt2[i,3],"incidence(s) of",input$type))
    }
    DotMap
  })
})