#### Preamble ####
# Purpose: Simulates
# Author: Ariel Xing
# Date: 14 November 2024
# Contact: ariel.xing@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(dplyr)


#### Simulate data ####
set.seed(123)  # for reproducibility

# Define vendors and date range
vendors <- c("Voila", "T&T", "Loblaws", "No Frills", "Metro", "Galleria", "Walmart", "Save-On-Foods")
start_date <- as.Date("2024-02-28")
end_date <- as.Date("2024-11-14")
dates <- seq(start_date, end_date, by = "day")

# Generate the dataset with a narrower avg_discount_rate range
n <- length(dates) * length(vendors)  # total number of rows

dataset <- data.frame(
  vendor = rep(vendors, each = length(dates)),
  date = rep(dates, times = length(vendors)),
  avg_discount_rate = runif(n, min = -20, max = 50)  # Random discount rates between -20 and 30
)

# Check the first few rows
head(dataset)

### Save simulated data 
write_csv(dataset, file = "data/Simulated_data/simulated_data.csv")
