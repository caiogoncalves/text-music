shinyServer(function(input, output, globar) {
  
  Playlists <- observeEvent(eventExpr = input$searchButton,
                            handlerExpr = get_user_playlists(input$user))
  
  names_playlist <- observe(if(nrow(Playlists) > 0){
    Playlists$playlist_name
  })
  
  output$selected_var <- renderText({ 
    names_playlist
  })
  ###FIM####
  })
