library(shiny)
library(plotly)
library(datasets)
library(dplyr)

df <- mtcars
df$am <- factor(df$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output){
    # Create scatterplot object 
    output$scatterplot <- renderPlotly({
        ggplotly({
            p <- ggplot(data = df, aes_string(x = input$x, y = input$y)) +
                geom_point(alpha = 0.8, size = 1) + theme_minimal()
            
            #if fit check box is selected, add a regression line
            if (input$fit) {
                p <- p + geom_smooth(method = "lm")
            }
            p
            
        })
    })
    
    # Add plot description
    output$description <- renderText({
        paste0("The plot above visualizes the relationship between ", 
               input$x, " and ", input$y, ".")
    })
    
    # Add regression summary
    output$descriptionreg <- renderText({
        paste0("The linear regression is between ", input$y, " and ", input$x, ".")
    })
    # add regression output
    output$lmoutput <- renderPrint({
        x <- df %>% pull(input$x)
        y <- df %>% pull(input$y)
        print(summary(lm(y~x, data = df)))
    })
})