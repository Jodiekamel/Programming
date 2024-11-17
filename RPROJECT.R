library("shiny")  #to build interactive dashboards in R
ui <- fluidPage(  # define UI of dashboard
  titlePanel("Interactive Data Analysis"),   #sets the title of the dashboard
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose Your File", accept = ".csv"),  #allows users to upload a CSV file for analysis
      sliderInput("centers", "Number of clusters:", min=2, max=4, value=3,step=1 ),  #to choose the number of clusters for K-means clustering
      numericInput("support", "Enter Minimum support from 0.001 --> 1:", value = 0),
      numericInput("confidence", "Enter Minimum confidence from 0.001 --> 1:", value = 0),
      actionButton("run", "Run the Program")
    ),
    mainPanel(   #display eloutput of eldata visualization and how by plotOutput and dataTableOutput
      fluidRow(
        column(width = 5, plotOutput("payment_type_pie")),
        column(width = 5, plotOutput("age_total_plot"))
      ),
      fluidRow(
        column(width = 5, plotOutput("total_by_city_plot")),
        column(width = 5, plotOutput("distribution_of_total_spending"))
      ),
      textOutput("kmeans_text"),
      tableOutput("kmeans"),
      textOutput("association_rules_text"),
      dataTableOutput("association_rules")
    )
  )
)
server <- function(input, output) {  #reacts to user input and updates the UI accordingly
  observeEvent(input$run, {      #this part beisht8l lama nedoos Run
    
    #Read CSV file
    library("reader")
    req(input$file)
    df = read.csv(input$file$datapath)  #It reads the uploaded CSV file and store it in variable df
    
    
    #Data Cleaning
    #It checks for duplicates, removes them, and checks for missing values
    sum(duplicated(df))  
    library("dplyr")   #dplyr for manipulating data frames or for cleaning up data
    dff=distinct(df)   #gwa el dplyr elunique msh m7taga dplyr btshil kol elrows elfiha duplicated
    dff
    sum(is.na(dff))   #btshhof kam wahda NA whattl3 b zero
    boxplot(dff[,c(2:4,6)])
    str(dff)        
    
    #Data Visualization
    #Dashboard
    #par(mfrow=c(2,2))
    
    #Compare cash and credit totals
    output$payment_type_pie <- renderPlot({   #3la 7asab el csv el haid5ol el graph hait8aiar 
      payment = table(dff$paymentType)
      payment
      percentage = paste0(round(100*payment/sum(payment),2),"%")
      percentage
      pie(payment,labels = percentage,main = "Compare payment type by percentage",col=c("pink","skyblue"))
      legend("bottomleft",legend = c("Cash", "Credit"),fill = c("pink", "skyblue"))  #elbox el3la elgamb
    })
    
    #Compare each age and sum of total spending
    #It creates a scatter plot showing the relationship between age and total spending
    output$age_total_plot <- renderPlot({
      data_grouped <- group_by(dff, age)  #beigm3 kol el3ndhom nafs elage
      data_summary <- summarise(data_grouped, total_spend = sum(total)) #It calculates the total spending for each age group
      data_summary
      plot(y = data_summary$total_spend,x = data_summary$age,col = "black",main = "Compare each age and sum of total spending",xlab = "Age",ylab = "Total Spending")
    })
    
    #Show each city total spending and arrange it by total descending
    output$total_by_city_plot <- renderPlot({
      data_group <- group_by(dff, city)
      datasumm <- summarise(data_group, totalspend = sum(total)) #It calculates the total spending for each city
      datasumm
      datasumm <- datasumm[order(datasumm$totalspend, decreasing = TRUE), ]   #It sorts the data by total spending in descending order
      datasumm
      barplot(height = datasumm$totalspend,name = datasumm$city,col = "lightgreen",main = "Compare city and total spending",xlab = "city",ylab = "Total Spending")
    })
    
    #Display the distribution of total spending
    output$distribution_of_total_spending <- renderPlot({
      boxplot( x = dff$total,main = "Total spending distribution",xlab = "Total spending",ylab = "frequency",col = "orange")
    })
    
    
    #Association rules
    library("arules")  #arules library for association rule mining
    split = strsplit(dff$items, ",")  
    tdata = transactions(split)  #It creates a transactions object (tdata) from the split items
    #summary(tdata)
    #class(tdata)
    #inspect(tdata)
    rules <- apriori(tdata, parameter = list(support = input$support, confidence = input$confidence,minlen=2))
    rules  #It uses the apriori function to mine association rules based on the user-specified minimum support and confidence value
    #inspect(rules)  #rules variable stores the discovered association rules
    
    output$kmeans <- renderTable({
      num_clusters =input$centers
      #clustering
      #function is used to compute summary statistics for each group created by group_by().
      grouped <- group_by(dff,customer,age)
      grouped <- summarise(grouped,total = sum(total))
      kmeans_result2=kmeans(grouped[c(3,2)],centers = num_clusters) 
      grouped$cluster=kmeans_result2$cluster
      grouped
    })
    
    output$association_rules <- renderDataTable({
      if (length(rules) == 0) {
        return(NULL)  # Return NULL if there are no rules
      } else {
        # Convert rules to data frame
        rules_df <- as(rules, "data.frame")
        return(rules_df)
      }
    })
    
    output$kmeans_text <- renderText({
      " k-means clustering result:"
    })
    output$association_rules_text <- renderText({
      "Association rule mining:"
    })
    
  })
}
shinyApp(ui = ui, server=server) #function used to create an interactive application in R using the shiny package