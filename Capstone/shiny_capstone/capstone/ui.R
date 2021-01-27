library(shiny)
library(shinythemes)


shinyUI(
    navbarPage("Capstone",
               tabPanel("Predict your next word",
                        fluidPage(
                            theme = shinytheme("sandstone"),
                            # Add title to current panel
                            titlePanel("Please type in your text"),
                            # Sidebar layout with input and output definitions
                            sidebarLayout(
                              sidebarPanel(
                              
                                hr(),
                                textInput("inputText", "Sentence:",value = ""),
                                #helpText("Check to see the back calculation with two, three and four words"),
                                #checkboxInput("debug", "Debug"),
                                br(),
                                h5('Instructions'),
                                helpText("Please type English text with space as separator"),
                                ),
                               
                                
                                # Output panel
                              mainPanel(
                                h1("Next word"),
                                verbatimTextOutput("Guessing..."),
                                h3(strong(code(textOutput("next_word")))),
                                br(),
                                br(),
                                br(),
                                br(),                       
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),                       
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                tags$b("Data Science Capstone Project"),
                                br(),
                                tags$b("Author: Tianming Jan 25 2021"),

               
               tabPanel("Github repository Page",
                        a("https://github.com/timmy1027/Data-Science"),
                        hr(),
                        h4("Thanks")
                        )
    )
)))))
