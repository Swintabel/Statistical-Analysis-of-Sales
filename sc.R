library(shiny)
library(shinydashboard)
library(ggplot2)
library(arulesViz)
library(DT)
library(plotly)
library(visNetwork)


ui <- dashboardPage(
  dashboardHeader(title = "Customer Insights Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Customer Purchase behaviour", tabName = "highrfm", icon = icon("chart-bar")),
      menuItem("Cost Group Analysis", tabName = "costgroup", icon = icon("chart-bar")),
      menuItem("Frequent Items", tabName = "frequent_items", icon = icon("shopping-cart"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "highrfm",
              fluidRow(box(plotOutput("highrfm_plot"), width = 6), 
                       box(plotOutput("highrfmCust_plot"), width = 6),
                       box(plotOutput("lowrfm_plot"), width = 6),
                       box(plotOutput("lowrfmCust_plot"), width = 6),
                       box(plotlyOutput("timetrend"), width = 12))),
      
      tabItem(tabName = "costgroup",
              fluidRow(box(plotOutput("product_plot"), width = 12),
              box(plotOutput("clusters"), width = 6),
              box(plotOutput("clusterBox"), width = 6))),
      
      tabItem(tabName = "frequent_items",
              fluidRow(box(
                visNetworkOutput("freq_plot", width = "100%", height = "600px"), 
                width = 12  # Maximize width
              )))
    )
  )
)



server <- function(input, output) {
  
  # RFM Plot
  output$highrfm_plot <- renderPlot({
    # Plot the top 10 dominant countries for high-value customers
    ggplot(top_10_high_value_countries, aes(x = reorder(Country, CustomerCount), y = CustomerCount)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      coord_flip() +  # Flip the coordinates for better readability +
      geom_text(aes(label = scales::comma(CustomerCount)), vjust = -0.3, color = "black")+
      labs(title = "Top 10 Dominant Countries for High-Value Customers",
           x = "Country",
           y = "Number of High-Value Customers") +
      theme_minimal()
  })
  
  # RFM Plot
  output$highrfmCust_plot <- renderPlot({
    # Plot the top 10 Products for low-value customers
    ggplot(top_10_high_value_products, aes(x = reorder(Description, TotalQuantity), y = TotalQuantity)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      coord_flip() +  # Flip the coordinates for better readability +
      geom_text(aes(label = scales::comma(TotalQuantity)), vjust = -0.3, color = "black")+
      labs(title = "Top 10 Products for High-Value Customers",
           x = "Country",
           y = "Number of High-Value Customers") +
      theme_minimal()
  })
  
  # RFM Plot
  output$lowrfm_plot <- renderPlot({
    # Plot the top 10 dominant countries for low-value customers
    ggplot(top_10_low_value_countries, aes(x = reorder(Country, CustomerCount), y = CustomerCount)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      coord_flip() +  # Flip the coordinates for better readability +
      geom_text(aes(label = scales::comma(CustomerCount)), vjust = -0.3, color = "black")+
      labs(title = "Top 10 Dominant Countries for Low-Value Customers",
           x = "Country",
           y = "Number of Low-Value Customers") +
      theme_minimal()
  })
  
  
  # RFM Plot
  output$lowrfmCust_plot <- renderPlot({
    # Plot the top 10 products for low-value customers
    ggplot(top_10_low_value_products, aes(x = reorder(Description, TotalQuantity), y = TotalQuantity)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      coord_flip() +  # Flip the coordinates for better readability +
      geom_text(aes(label = scales::comma(TotalQuantity)), vjust = -0.3, color = "black")+
      labs(title = "Top 10 Products for Low-Value Customers",
           x = "Country",
           y = "Number of Low-Value Customers") +
      theme_minimal()
  })
  
  # RFM Plot
  output$timetrend <- renderPlotly({
    ggplot(purchase_periods, aes(x = Month, y = TotalPurchaseValue, color = CLV_Segment)) +
      geom_line() +
      theme_minimal() +
      labs(title = "Purchase Trends Over Time") 
  })
  
  # Cost Group
  output$product_plot <- renderPlot({
    ggplot(top_10_per_cluster, aes(x = TotalQuantity, y = reorder(Description, TotalQuantity), fill = Cluster)) +
      geom_col() +  # Use stat="identity" to plot actual values
      facet_wrap(~ Cluster, scales = "free") +  # Separate clusters into panels
      labs(title = "Top 10 Products in Each Cluster",
           x = "Total Quantity Sold",
           y = "Product") +
      theme_minimal() +
      coord_flip() +  # Flips axes for better readability
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size=8), axis.text.y = element_text(size = 6))  # Rotate labels

  })
  
  # Cost Group
  output$clusters <- renderPlot({
    #clusters plot
    ggplot(df_cluster, aes(x = AvgPrice, y = Cluster, color = Cluster)) +
      geom_point(alpha = 0.7) +
      theme_minimal() +
      labs(title = "Product Clustering by Price", x = "Average Price", y = "Cluster") 
    
  })
  
  # Cost Group
  output$clusterBox <- renderPlot({
    ggplot(df, aes(x = Cluster, y = Quantity)) +
      geom_boxplot() +
      scale_y_log10() +  # Log scale to compress extreme values
      theme_minimal() +
      labs(title = "Box Plot of Quantity by Cluster (Log Scale)", 
           x = "Cluster", y = "Quantity (Log Scale)") 
    
  })
  
  
  # Frequent Itemsets Plot
  output$freq_plot <- renderVisNetwork({
    # Plot the top 100 rules based on 'lift' or any other metric
    plot(subrules, method = "graph", engine = "htmlwidget", control = list(max = 100))
  })
  

}



shinyApp(ui = ui, server = server)
