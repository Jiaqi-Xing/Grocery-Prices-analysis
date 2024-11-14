#### Preamble ####
# Purpose: Tests data
# Author: Ariel Xing
# Date: 11 November 2023
# Contact: ariel.xing3927@gmail.com
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(validate)

dataset <- read.csv("data/Simulated_data/simulated_data.csv")

# Define vendors and date range for checks
expected_vendors <- c("Voila", "T&T", "Loblaws", "No Frills", "Metro", "Galleria", "Walmart", "Save-On-Foods")
start_date <- as.Date("2024-02-28")
end_date <- as.Date("2024-11-14")

# Validation rules including check for NA values
rules <- validator(
  avg_discount_rate >= -20 & avg_discount_rate <= 50,     # Check discount rate is in the correct range
  vendor %in% expected_vendors,                           # Ensure vendor is in the expected list
  date >= start_date & date <= end_date,                  # Date is within the specified range
  !is.na(avg_discount_rate),                              # Check no NA in avg_discount_rate
  !is.na(vendor),                                         # Check no NA in vendor
  !is.na(date)                                            # Check no NA in date
)

# Validate the dataset
validation_results <- confront(dataset, rules)

# Summary of validation results
summary(validation_results)

