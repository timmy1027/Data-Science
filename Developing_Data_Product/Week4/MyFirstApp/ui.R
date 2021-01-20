library(shiny)
library(shinythemes)
library(plotly)

shinyUI(
    navbarPage("Week4 Project",
               tabPanel("Analysis",
                        fluidPage(
                            theme = shinytheme("sandstone"),
                            # Add title to current panel
                            titlePanel("Analysis of mtcars dataset by Tianming"),
                            # Sidebar layout with input and output definitions
                            sidebarLayout(
                                sidebarPanel(
                                    h3("Plotting"),
                                    # Select variable for y-axis
                                    selectInput(inputId = "y",
                                                label = "Y-axis:",
                                                choices = c("Miles/(US) gallon" = "mpg",
                                                            "Weight(1000 lbs)" = "wt",
                                                            "1/4 mile time" = "qsec"),
                                                selected = "mpg"),
                                    # Select variable for x-axis
                                    selectInput(inputId = "x",
                                                label = "Scatterplot X-axis",
                                                choices = c("Number of cylinders" = "cyl",
                                                          "Number of carburetors" = "carb",
                                                          "Rear axie ratio" = "drat"),
                                                selected = "cyl"
                                                ),
                                    
                                    checkboxInput("fit", "Add best fit line to Scatterplot", TRUE)
                                            ),
                               
                                
                                # Output panel
                                mainPanel(
                                    tabsetPanel(type = "tabs",
                                    #Tab 1 plot
                                    tabPanel(title = "Plots",
                                    h3("Scatterplot"),
                                    plotlyOutput(outputId = "scatterplot"),
                                    textOutput(outputId = "description"),
                                    ),
                                    
                                    #Tab 2 Regression
                                    tabPanel(title = "Regression",
                                    h3("Simple Linear Regression Summary"),
                                    h4("regression mode = lm"),
                                    textOutput(outputId = "descriptionreg"),
                                    verbatimTextOutput(outputId = "lmoutput")
                                            )
                                        )
                                                )
                                            )
                                    )
                                ),

               
               tabPanel("Appendix",
                        h2("dataset: mtcars"),
                        hr(),
                        h3("Description"),
                        helpText("The data was extracted from the 1974 Motor Trend US magazine,",
                                 " and comprises fuel consumption and 10 aspects of automobile design and performance",
                                 " for 32 automobiles (1973-74 models)."),
                        h3("Format"),
                        p("A data frame with 32 observations on 11 variables."),
                        
                        p("  [, 1]   mpg         Miles/(US) gallon"),
                        p("  [, 2]	 cyl	 Number of cylinders"),
                        p("  [, 3]	 disp	 Displacement (cu.in.)"),
                        p("  [, 4]	 hp	 Gross horsepower"),
                        p("  [, 5]	 drat	 Rear axle ratio"),
                        p("  [, 6]	 wt	 Weight (lb/1000)"),
                        p("  [, 7]	 qsec	 1/4 mile time"),
                        p("  [, 8]	 vs	 V/S"),
                        p("  [, 9]	 am	 Transmission (0 = automatic, 1 = manual)"),
                        p("  [,10]	 gear	 Number of forward gears"),
                        p("  [,11]	 carb	 Number of carburetors"),
                        
                        h3("Note"),
                        p("Henderson and Velleman (1981) comment in a footnote to Table 1: ‘Hocking [original transcriber]'s noncrucial coding of the Mazda's rotary engine as a straight six-cylinder engine and the Porsche's flat engine as a V engine, as well as the inclusion of the diesel Mercedes 240D, have been retained to enable direct comparisons to be made with previous analyses."),
                        
                        h3("Source"),
                        
                        p("Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391-411.")
                        ),
               tabPanel("Github repository Page",
                        a("https://github.com/timmy1027/Data-Science/tree/master/Developing_Data_Product/Week4"),
                        hr(),
                        h4("Thanks")
                        )
    )
)