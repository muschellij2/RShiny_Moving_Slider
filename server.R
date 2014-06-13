library(shiny)

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The output functions defined 
  # below then all use the value computed from this expression
  data <- reactive({
    dist <- rnorm
    dist(input$n)
  })
  

    # Partial example
  output$sliderUI <- renderUI({
    i = input$n
    if (is.null(i)){
      i = 499
    } else {
      Sys.sleep(.25)
    }
    i = i + 1
    maxval = 1000
    if (i > maxval) {
      i = (i %% maxval)
    }
    print(i)
    sliderInput("n", 
              "Number of observations:", 
               value = i,
               min = 1, 
               max = maxval)
  })  

  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the data reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    
    hist(data(), 
         main=paste('r', dist, '(', n, ')', sep=''))
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x=data())
  })
  
})
