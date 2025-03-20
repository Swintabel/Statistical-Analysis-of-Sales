library(odbc)
library(DBI)

con <- dbConnect(odbc::odbc(),
                 Driver = "ODBC Driver 17 for SQL Server",
                 Server = "localhost",
                 Database = "porfolio",
                 Trusted_Connection = "Yes")

df <- dbGetQuery(con, "SELECT * FROM SalesB")
head(df)  # View the first few rows

dbDisconnect(con)

