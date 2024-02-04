#This code segment outlines the steps taken to load, preprocess, and clean the training and testing datasets for the Airline Customer Satisfaction Analysis Project. It includes setting up the environment, loading necessary libraries, handling missing values, and converting categorical variables into a format suitable for logistic regression analysis.

## Environment Setup
# Setting the working directory to where the dataset is located
setwd('C:/Desktop/Airline Passenger Satisfaction Dataset')

# Loading necessary libraries
require(tidyr)
library(forecast)
library(dplyr)
library(caret)

## Load data
# Reading the training and testing datasets
train <- read.csv('train.csv')
test <- read.csv('test.csv')

## Data Preparation and Cleaning for Training Dataset
# Displaying the first few rows of the training data
head(train)

# Checking for NA values in the training dataset and summing them up
sum(is.na(train))

# Dropping records with NA values from the training dataset
train <- train %>% drop_na()

# Generating dummy variables for categorical variables in the training dataset
# Converting 'Gender' into a binary variable
table(train$Gender)
train$is.Male <- ifelse(train$Gender == 'Male', 1, 0)

# Converting 'Customer.Type' into a binary variable
table(train$Customer.Type)
train$is.Loyal <- ifelse(train$Customer.Type == 'Loyal Customer', 1, 0)

# Converting 'Type.of.Travel' into a binary variable
table(train$Type.of.Travel)
train$is.Business <- ifelse(train$Type.of.Travel == 'Business travel', 1, 0)

# Converting 'Class' into binary variables
table(train$Class)
train$is.BusinessClass <- ifelse(train$Class == 'Business', 1, 0)
train$is.EcoPlusClass <- ifelse(train$Class == 'Eco Plus', 1, 0)

# Converting 'satisfaction' into a binary variable
table(train$satisfaction)
train$is.Satisfied <- ifelse(train$satisfaction == 'satisfied', 1, 0)

# Removing original categorical variables after creating dummy variables
train <- subset(train, select = -c(Gender, Customer.Type, Type.of.Travel, Class, satisfaction))

# Displaying the first few rows after preprocessing
head(train)

## Data Preparation and Cleaning for Testing Dataset
# Displaying the first few rows of the testing data
head(test)

# Checking for NA values in the testing dataset and summing them up
sum(is.na(test))

# Dropping records with NA values from the testing dataset
test <- test %>% drop_na()

# Repeating the process of generating dummy variables for the test dataset
test$is.Male <- ifelse(test$Gender == 'Male', 1, 0)
test$is.Loyal <- ifelse(test$Customer.Type == 'Loyal Customer', 1, 0)
test$is.Business <- ifelse(test$Type.of.Travel == 'Business travel', 1, 0)
test$is.BusinessClass <- ifelse(test$Class == 'Business', 1, 0)
test$is.EcoPlusClass <- ifelse(test$Class == 'Eco Plus', 1, 0)
test$is.Satisfied <- ifelse(test$satisfaction == 'satisfied', 1, 0)

# Removing original categorical variables after creating dummy variables for the test dataset
test <- subset(test, select = -c(Gender, Customer.Type, Type.of.Travel, Class, satisfaction))

# Displaying the first few rows after preprocessing
head(test)
