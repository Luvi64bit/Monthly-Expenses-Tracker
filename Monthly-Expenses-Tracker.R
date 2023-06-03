
# Load required packages
library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(DT)
library(reshape2)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Monthly Expenses Calculator"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Expenses", tabName = "expenses")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "expenses",
              fluidPage(
                sidebarLayout(
                  sidebarPanel(
                    selectInput("month", "Month", choices = month.name),
                    numericInput("year", "Year", value = 2023),
                    numericInput("rent", "Rent", value = 0),
                    numericInput("utilities", "Utilities", value = 0),
                    numericInput("groceries", "Groceries", value = 0),
                    numericInput("transportation", "Transportation", value = 0),
                    numericInput("others", "Others", value = 0),
                    actionButton("calculate", "Calculate"),
                    actionButton("delete", "Delete Selected Row")
                  ),
                  mainPanel(
                    h2("Total Monthly Expenses"),
                    textOutput("total"),
                    h2("Expenses Table"),
                    DTOutput("expensesTable"),
                    plotlyOutput("graph")
                  )
                )
              )
      )
    )
  )
)

# Define server
server <- function(input, output) {
  expenses <- reactiveValues(total = 0, data = data.frame(Month = character(), Year = numeric(), Category = character(), Amount = numeric()))
  
  observeEvent(input$calculate, {
    month <- input$month
    year <- input$year
    rent <- input$rent
    utilities <- input$utilities
    groceries <- input$groceries
    transportation <- input$transportation
    others <- input$others
    total_expenses <- sum(rent, utilities, groceries, transportation, others)
    
    expenses$total <- total_expenses
    
    new_row <- data.frame(Month = month, Year = year, Rent = rent, Utilities = utilities, Groceries = groceries, Transportation = transportation, Others = others, Total = total_expenses)
    expenses$data <- rbind(expenses$data, new_row)
  })
  
  observeEvent(input$delete, {
    selected_rows <- input$expensesTable_rows_selected
    expenses$data <- expenses$data[-selected_rows, ]
  })
  
  output$total <- renderText({
    paste("Total Monthly Expenses: $", expenses$total)
  })
  
  output$expensesTable <- renderDT({
    datatable(expenses$data, options = list(pageLength = 5), selection = "multiple", rownames = FALSE)
  })
  
  output$graph <- renderPlotly({
    df <- expenses$data
    df <- melt(df, id.vars = c("Month", "Year"), measure.vars = c("Rent", "Utilities", "Groceries", "Transportation", "Others"))
    
    plot <- ggplot(df, aes(x = Month, y = value, fill = variable)) +
      geom_bar(stat = "identity", position = "stack") +
      labs(title = "Monthly Expenses by Category", x = "Month", y = "Amount") +
      scale_fill_manual(values = c("Rent" = "blue", "Utilities" = "green", "Groceries" = "red", "Transportation" = "orange", "Others" = "purple")) +
      theme_minimal()
    
    ggplotly(plot)
  })
}

# Run the app
shinyApp(ui, server)
