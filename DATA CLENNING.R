# Load required libraries
library(dplyr)
library(readr)

# Load the dataset
df <- read_csv("SPSS OUTREACH QUESTIONNAIRE.sav group1.csv")

# Check for missing values
colSums(is.na(df))  # Count missing values in each column

# Convert categorical variables (assuming 'sex', 'plzspecifynetoref' are categorical)
df$sex <- as.factor(df$sex)
df$plzspecifynetoref <- as.factor(df$plzspecifynetoref)

# Rename columns to lower case and remove spaces
colnames(df) <- tolower(gsub(" ", "_", colnames(df)))

# Remove unnecessary variables (if 'VAR00001' and 'VAR00002' are redundant)
df <- select(df, -c(var00001, var00002))

# Remove duplicate rows
df <- distinct(df)

# Ensure values are within expected ranges (example: 'sex' should be 1 or 2)
df <- df %>% filter(sex %in% c(1, 2))

# Replace blank or inconsistent values in categorical columns
df$plzspecifynetoref[df$plzspecifynetoref == ""] <- NA  # Convert blanks to NA

# Save the cleaned data
write_csv(df, "cleaned_outreach_data.csv")

# Display summary of cleaned dataset
summary(df)

