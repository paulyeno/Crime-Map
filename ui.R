library(shiny);library(rCharts)
shinyUI(fluidPage(fluidRow(
  column(4,selectInput("type","Type of Crime",choices=c("Vehicle crime",
    "Violence and sexual offences","Anti-social behaviour","Bicycle theft",
    "Other theft","Theft from the person","Criminal damage and arson",
    "Other crime","Drugs","Burglary","Public order","Shoplifting","Robbery",
    "Possession of weapons"),
    selected=NULL
    )
  ),
  column(8,chartOutput('DotMap','leaflet'))
  )
  )
)