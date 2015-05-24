library(shiny)
filenames<-list.files(pattern="\\.csv$")


shinyUI(
  navbarPage("Wine Quality",
             tabPanel("Understanding Wine Quality",
                      h2("Wine Quality"),
                      hr(),
                      h3("This dataset is public available for research. The details are described in [Cortez et al., 2009]. 
  Please include this citation if you plan to use this database:

  P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis. 
  Modeling wine preferences by data mining from physicochemical properties.
  In Decision Support Systems, Elsevier, 47(4):547-553. ISSN: 0167-9236."),
                      helpText("Available at: [@Elsevier] http://dx.doi.org/10.1016/j.dss.2009.05.016",
                               " [Pre-press (pdf)] http://www3.dsi.uminho.pt/pcortez/winequality09.pdf",
                               " [bib] http://www3.dsi.uminho.pt/pcortez/dss09.bib."),
                      h3("Format"),
                      p("A data frame with 6497 observations on 11 variables."),
                        
                      p("  1. Title: Wine Quality"),
                      p("  2. Sources
   Created by: Paulo Cortez (Univ. Minho), Antonio Cerdeira, Fernando Almeida, Telmo Matos and Jose Reis (CVRVV) @ 2009"),
                      p("  3. Past Usage:

  P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis. 
  Modeling wine preferences by data mining from physicochemical properties.
  In Decision Support Systems, Elsevier, 47(4):547-553. ISSN: 0167-9236.

  In the above reference, two datasets were created, using red and white wine samples.
  The inputs include objective tests (e.g. PH values) and the output is based on sensory data
  (median of at least 3 evaluations made by wine experts). Each expert graded the wine quality 
  between 0 (very bad) and 10 (very excellent). Several data mining methods were applied to model
  these datasets under a regression approach. The support vector machine model achieved the
  best results. Several metrics were computed: MAD, confusion matrix for a fixed error tolerance (T),
  etc. Also, we plot the relative importances of the input variables (as measured by a sensitivity
  analysis procedure).  DISCLAIMER: Mario Solano has merged the 2 datasets into a single one for thi Shiny Project"),
                      p("  4. Relevant Information:

   The two datasets are related to red and white variants of the Portuguese Vinho Verde wine.
   For more details, consult: http://www.vinhoverde.pt/en/ or the reference [Cortez et al., 2009].
   Due to privacy and logistic issues, only physicochemical (inputs) and sensory (the output) variables 
   are available (e.g. there is no data about grape types, wine brand, wine selling price, etc.).

   These datasets can be viewed as classification or regression tasks.
   The classes are ordered and not balanced (e.g. there are munch more normal wines than
   excellent or poor ones). Outlier detection algorithms could be used to detect the few excellent
   or poor wines. Also, we are not sure if all input variables are relevant. So
   it could be interesting to test feature selection methods. "),
                      p("  5. Number of Instances: red wine - 1599; white wine - 4898. 
"),
                      p("  6. Number of Attributes: 11 + output attribute"),
                      p("  7. Attribute information:

   For more information, read [Cortez et al., 2009].

   Input variables (based on physicochemical tests):
   1 - fixed acidity
   2 - volatile acidity
   3 - citric acid
   4 - residual sugar
   5 - chlorides
   6 - free sulfur dioxide
   7 - total sulfur dioxide
   8 - density
   9 - pH
   10 - sulphates
   11 - alcohol
   Output variable (based on sensory data): 
   12 - quality (score between 0 and 10)
   13 - Wine Type (red or white"),
                      p("  8. Missing Attribute Values: None"),
                      
                      h3("Source"),
                      
                      p("Available at: [@Elsevier] http://dx.doi.org/10.1016/j.dss.2009.05.016,
                        [Pre-press (pdf)] http://www3.dsi.uminho.pt/pcortez/winequality09.pdf,
                        [bib] http://www3.dsi.uminho.pt/pcortez/dss09.bib.")
             ),

             tabPanel("How to use this app?",

                      h2("Follow these steps and you are good to go!"),
                      hr(),
                      h3("The App has four tabs"),
                      p("1 - Understanding Wine Quality: bring the user to the world of wine making"),
                      p("2 - How to use this app?"),
                      p("3 - Analyzing White and Red Wine: loads a datase set that allows user to use boxplots for each attributes vs Wine Type, and also run Linear Regressions againts the Wine Quality Label"),
                      p("4 - Source Code: Github repository containint the code to buil this Shiny App"),
                      
                      helpText(""),
                      h2("Using the App to Analyze Wine Quality"),
                      h3("Left Navigation Tab"),
                      p("The drop down menu has the 11 available variables from the data set. Click on the drop down menu, to select 1 variable and it will automatically change the behavior of the boxplot and linear regression"),
                      h3("Main Panel Navigation Tab"),
                      hr(),
                      h3("Data Tab"),
                      p("Loads the winequality.csv file.  Shows the first 20 rows as reference for the user"),
                      hr(),
                      h3("BoxPlot"),
                      p("Show a box plot of the variable selected in the drop down menu in Y vs the Wine Type in X.  Wine Type = Red or White Wine"),
                      hr(),
                      h3("Regression Model"),
                      p("Generates a regression model of quality ~ variable selected in drop down menu")
                      
             ),
             
             tabPanel("Analyzing White and Red Wine",
                      fluidPage(
                        titlePanel("Wine Quality vs its production variables"),
                        
                        
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("variable", "Variable:",
                                        c("Fixed Acidity" = "fixed.acidity",
                                          "Volatile Acidity" = "volatile.acidity",
                                          "Citric Acid" = "citric.acid",
                                          "Residual Sugar" = "residual.sugar",
                                          "Chlorides" = "chlorides",
                                          "Free Sulfur Dioxide" = "free.sulfur.dioxide",
                                          "Total Sulfur Dioxide" = "total.sulfur.dioxide",
                                          "Density" = "density",
                                          "pH" = "pH",
                                          "Sulphates" = "sulphates",
                                          "Alcohol Output variable (based on sensory data)" = "alcohol"
                                        ))
                          ),
           
              
                 
                          
                          mainPanel(
                      
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Data",tableOutput("data_table"),id="myTab"),
                                        tabPanel("BoxPlot", h3(textOutput("caption")), plotOutput("QualityBoxPlot")),
                                        tabPanel("Regression model", h3(textOutput("caption2")), plotOutput("QualityPlot")),
                                        verbatimTextOutput("fit")
                                        )
                            )
                          )
                        )
             ),
  
             tabPanel("SourceCode",
                      p("Developing_Data_Products_Coursera_Part1"),
                      a("https://github.com/msolanoo/WineQuality")
             )

             
             
             
  )
)
