library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Minhas Musicas"),
  dashboardSidebar(sidebarSearchForm(textId = "user", buttonId = "searchButton",
                                     label = "Usuario")),
  dashboardBody(
    
    textOutput("selected_var")
    
    
  )
)
