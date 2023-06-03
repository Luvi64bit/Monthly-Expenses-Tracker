# Monthly Expenses Tracker

The Monthly Expenses Tracker is a Shiny app that allows users to calculate and track their monthly expenses. With a user-friendly interface, it enables users to input their expenses for various categories such as rent, utilities, groceries, transportation, and others. The app provides a summarized view of the total monthly expenses and displays a table showcasing the entered data. Additionally, it offers an interactive graph that visualizes the expenses by category, allowing users to identify spending patterns over time. The app also includes a feature to delete selected rows from the table, dynamically updating both the table and the graph.

## Features

- Input monthly expenses for different categories
- Calculate and display the total monthly expenses
- Show a table of entered expenses
- Visualize expenses by category using an interactive graph
- Delete selected rows from the table, with automatic updates to the graph

## Technologies Used

- R programming language
- Shiny framework for creating web applications in R
- Shinydashboard for creating a dashboard-style layout
- ggplot2 and plotly for data visualization
- DT for interactive data tables
- Reshape2 for data manipulation

## Installation and Usage

1. Make sure you have R and RStudio installed on your machine.
2. Clone this repository or download the project files.
3. Open the RStudio project file (.Rproj).
4. Install the required packages by running the following command in the RStudio console:

```R
install.packages(c("shiny", "shinydashboard", "ggplot2", "plotly", "reshape2", "DT"))

Run the app by clicking the "Run App" button in the RStudio toolbar or by running the following command in the RStudio console:

shiny::runApp()

The app will open in a web browser, and you can start using it to calculate and track your monthly expenses.
