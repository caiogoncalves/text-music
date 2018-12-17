shinyServer(function(input, output, globar) {
  
  Playlists <- eventReactive(input$searchButton, {
    get_user_playlists(input$user)
  })
  
  output$selected_var <- renderText({
    Playlists()$playlist_name
  })
})
