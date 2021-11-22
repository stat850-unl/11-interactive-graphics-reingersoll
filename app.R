library(shiny)
library(ggplot2)
library(dplyr)

library(rsconnect)
# rsconnect::deployApp('C:\\Users\\airr0\\Desktop\\Stat 850\\11-interactive-graphics-reingersoll')

#TidyTuesday Cocktail Data 
cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/cocktails.csv')


ui = fluidPage(
    titlePanel("Cocktail Ingredients"),
    sidebarPanel(
        #creating a drop-down menu for ingredients
        selectInput(inputId = "ingredient_type", 
                    label = "Ingredient", 
                    choices = sort(unique(cocktails$ingredient)), selected = "7-Up")
    ),
    #location of the histogram
    mainPanel(
        plotOutput(outputId = "category"),
    )
    
    
)


server = function(input, output) {
    #function to filter by ingredient
    cocktails_subset <- reactive({
        cocktails %>%
            filter(ingredient == input$ingredient_type)
    })

    #creating the bar graph
    output$category <- renderPlot({
        ggplot(cocktails_subset(), aes(x = category, color = category)) + 
            geom_bar()+
            labs(x = "Category", y = "Total", title = "Cocktails")
    })
}




shinyApp(ui = ui, server = server)
