###################################
### Group Name: Worker Bees     ###
### Maryam Ali                  ###
### Connor Doyle                ###
### Douglas Hopkins             ###
### Abraham Ibanez Garcia       ###
### April Kiyabu                ###
### Zahra Tahmasebi             ###
### Fall 2022 ISDS 574 - 59     ###
### Group Project               ###
###################################

## Environment Setup
# Path to the directory will need to be updadted depending on your own machine
setwd('C:/Users/dhopk/Desktop/Grad School/CSUF/2022/Fall 2022/ISDS 574/Group Project/Airline Passenger Satisfaction Dataset')
require(tidyr)
library(forecast)
library(dplyr)
library(caret)

## Load data
train <- read.csv('train.csv')
test <- read.csv('test.csv')

## data prep and cleaning ##
head(train)
#drop records with NA values from training dataset
sum(is.na(train))
train <- train %>% drop_na()

#generate dummy variables for categorical variables in training dataset
table(train$Gender)
train$is.Male <- ifelse(train$Gender == 'Male', 1, 0)

table(train$Customer.Type)
train$is.Loyal <- ifelse(train$Customer.Type == 'Loyal Customer', 1, 0)

table(train$Type.of.Travel)
train$is.Business <- ifelse(train$Type.of.Travel == 'Business travel', 1, 0)

table(train$Class)
train$is.BusinessClass <- ifelse(train$Class == 'Business', 1, 0)
train$is.EcoPlusClass <- ifelse(train$Class == 'Eco Plus', 1, 0)

table(train$satisfaction)
train$is.Satisfied <- ifelse(train$satisfaction == 'satisfied', 1, 0)

head(train)
train <- subset(train, select = -c(Gender, Customer.Type, Type.of.Travel, 
                                   Class, satisfaction))
head(train)


head(test)
#drop records with NA values from test dataset
sum(is.na(test))
test <- test %>% drop_na()

#generate dummy variables for categorical variables in test dataset
test$is.Male <- ifelse(test$Gender == 'Male', 1, 0)

test$is.Loyal <- ifelse(test$Customer.Type == 'Loyal Customer', 1, 0)

test$is.Business <- ifelse(test$Type.of.Travel == 'Business travel', 1, 0)

test$is.BusinessClass <- ifelse(test$Class == 'Business', 1, 0)
test$is.EcoPlusClass <- ifelse(test$Class == 'Eco Plus', 1, 0)

test$is.Satisfied <- ifelse(test$satisfaction == 'satisfied', 1, 0)

head(test)
test <- subset(test, select = -c(Gender, Customer.Type, Type.of.Travel, 
                                 Class, satisfaction))
head(test)

## Logistic Regression
#reg on all variables
log_reg <- glm(is.Satisfied ~ ., data = 
                 subset(train, select = -c(X, id)) #obit X and id from regression
               , family = 'binomial')
options(scipen = 999)
summary(log_reg)

#drop insignificant variables (flight distance)
log_reg <- glm(is.Satisfied ~ ., data = 
                 subset(train, select = -c(X, id, Flight.Distance)) 
               , family = 'binomial')
options(scipen = 999)
summary(log_reg)
# This full model can help determine prescriptive policies to help improve 
# customer satisfaction in the future. Some of these variables would be 
# unknown to the airline until after they survey the customer. Examples of 
# such variables are:
# In flight WiFi service
# Departure/Arrival time convenient
# Ease of Online booking
# Food and drink
# Online boarding
# Seat comfort
# In flight entertainment
# On-board service
# Leg room service
# Baggage handling
# Check-in service
# In flight service
# Cleanliness
# Gate.location
# Modeling based on these variables would allow the airline to determine 
# what services they need to focus on the most to boost customer satisfaction.
# Some other variables may not be known until the shortly before or after the 
# flight. Examples of such variables are:
# Departure.Delay.in.Minutes
# Arrival.Delay.in.Minutes
# Though these variables may be out of the airline's control, they can still
# be leveraged to determine if a follow-up campaign needs to be put in place 
# to mitigate unsatisfied customers based on circumstances that arise on the 
# date of the flight. 
# The remaining variables can be used to predict customer satisfaction in 
# advance of the flight since the value to these variables are likely known to
# the airline as early as when the customer books the flight. 

# I propose that we build 3 models:
# Booking model:
# This model is to be used to assign a satisfaction likelihood to each 
# customer as soon as they book the flight. 
# Follow-up model:
# This model is to be used to assign a satisfaction likelihood to each 
# customer shortly after the flight lands. This will allow the airline 
# to be proactive in contacting customers that are likely to be 
# unsatisfied due to the events that occurred the day of the flight.
# Prescriptive model:
# This model is to be used to determine what aspects of the services 
# provided by the airline need to be improved. 

## Booking model
log_reg_b <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = c(Age,
                                            is.Male,
                                            is.Loyal,
                                            is.Business,
                                            is.BusinessClass,
                                            is.EcoPlusClass,
                                            is.Satisfied
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_b) 
# Age and Gender and insignificant for this model, plus, if this model is used
# to determine preferential treatment, then Age and Gender may be discriminatory

log_reg_b <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = c(is.Loyal,
                                            is.Business,
                                            is.BusinessClass,
                                            is.EcoPlusClass,
                                            is.Satisfied
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_b) #This is the final booking model
# Testing model
booking_pred <- predict(log_reg_b, subset(test, select = c(is.Loyal,
                                                           is.Business,
                                                           is.BusinessClass,
                                                           is.EcoPlusClass)), 
                        type = 'response')
head(booking_pred)
booking_pred_50 <- round(booking_pred, digits = 0) #Cut-off at 50%
head(booking_pred_50)

confusionMatrix(as.factor(booking_pred_50), as.factor(test$is.Satisfied),
                dnn = c('Prediction', 'Actuals')) #Accuracy : 0.7791 
#I tried other cutoff points, but 50% seems to be a good choice

## Follow-up Model
log_reg_f <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = c(is.Loyal,
                                            is.Business,
                                            is.BusinessClass,
                                            is.EcoPlusClass,
                                            Departure.Delay.in.Minutes,
                                            Arrival.Delay.in.Minutes,
                                            is.Satisfied
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_f) 

# Testing model
follow_up_pred <- predict(log_reg_f, subset(test, select = c(is.Loyal,
                                                             is.Business,
                                                             is.BusinessClass,
                                                             is.EcoPlusClass,
                                                             Departure.Delay.in.Minutes,
                                                             Arrival.Delay.in.Minutes)), 
                          type = 'response')
head(follow_up_pred)
follow_up_pred_50 <- round(follow_up_pred, digits = 0) #Cut-off at 50%
head(follow_up_pred_50)

confusionMatrix(as.factor(follow_up_pred_50), as.factor(test$is.Satisfied),
                dnn = c('Prediction', 'Actuals')) #Accuracy : 0.7816

## Prescriptive Model
log_reg_p <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = -c(X, 
                                             id, 
                                             Age, 
                                             Flight.Distance,
                                             Departure.Delay.in.Minutes,
                                             Arrival.Delay.in.Minutes,
                                             is.Male, 
                                             is.Loyal,
                                             is.Business,
                                             is.BusinessClass,
                                             is.EcoPlusClass
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_p) #in flight service is insignificant

log_reg_p <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = -c(X, 
                                             id, 
                                             Age, 
                                             Flight.Distance,
                                             Departure.Delay.in.Minutes,
                                             Arrival.Delay.in.Minutes,
                                             is.Male, 
                                             is.Loyal,
                                             is.Business,
                                             is.BusinessClass,
                                             is.EcoPlusClass,
                                             Inflight.service
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_p)

# Testing model
prescriptive_pred <- predict(log_reg_p, subset(test, select = -c(X, 
                                                                 id, 
                                                                 Age, 
                                                                 Flight.Distance,
                                                                 Departure.Delay.in.Minutes,
                                                                 Arrival.Delay.in.Minutes,
                                                                 is.Male, 
                                                                 is.Loyal,
                                                                 is.Business,
                                                                 is.BusinessClass,
                                                                 is.EcoPlusClass,
                                                                 Inflight.service,
                                                                 is.Satisfied)), 
                             type = 'response')
head(prescriptive_pred)
prescriptive_pred_50 <- round(prescriptive_pred, digits = 0) #Cut-off at 50%
head(prescriptive_pred_50)

confusionMatrix(as.factor(prescriptive_pred_50), as.factor(test$is.Satisfied),
                dnn = c('Prediction', 'Actuals')) #Accuracy : 0.8134 


#Group Project Extra Work


#Misclassification rates 
#booking model
cm_b <- confusionMatrix(as.factor(booking_pred_50), as.factor(test$is.Satisfied),
                        dnn = c('Prediction', 'Actuals'))
misclassification_rate = cm_b$overall[1]
1-misclassification_rate

#follow up model
cm_f <- confusionMatrix(as.factor(follow_up_pred_50), as.factor(test$is.Satisfied),
                        dnn = c('Prediction', 'Actuals'))

misclassification_rate = cm_f$overall[1]
1-misclassification_rate

#prescriptive model
cm_p <- confusionMatrix(as.factor(prescriptive_pred_50), as.factor(test$is.Satisfied),
                        dnn = c('Prediction', 'Actuals'))

misclassification_rate = cm_p$overall[1]
1-misclassification_rate
#scatter plots


#Dimension reduction
options(digits = 2)
pcs.cov <- prcomp(train.norm[c(20,21,22,23)], scale=FALSE)
summary(pcs.cov)
pcs.cov$rot
scores <- pcs.cov$x
head(scores)

#reg on all variables
log_reg <- glm(is.Satisfied ~ pcs.cov$x[,1:18], data = 
                 train.norm, family = 'binomial')
options(scipen = 999)
summary(log_reg)



#booking model
options(digits = 2)
pcs.cov <- prcomp(train.norm[c(20,21,22,23)])
summary(pcs.cov)
pcs.cov$rot
scores <- pcs.cov$x
head(scores)


log_reg_b <- glm(is.Satisfied ~ pcs.cov$x[,1:3], data = 
                   subset(train.norm, select = c(is.Loyal,
                                                 is.Business,
                                                 is.BusinessClass,
                                                 is.EcoPlusClass,
                                                 is.Satisfied
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_b) #This is the final booking model


# Testing model
booking_pred <- predict(log_reg_b, subset(test, select = c(is.Loyal,
                                                           is.Business,
                                                           is.BusinessClass,
                                                           is.EcoPlusClass)), 
                        type = 'response')
head(booking_pred)
booking_pred_50 <- round(booking_pred, digits = 0) #Cut-off at 50%
head(booking_pred_50)

confusionMatrix(as.factor(booking_pred_50), as.factor(test$is.Satisfied),
                dnn = c('Prediction', 'Actuals')) 




library(MASS)

#Heatmap for ccorrelations
library(ggplot2)
library(reshape) # to generate input for the plot
cor.mat <- round(cor(train[-c(1,2)]),2) # rounded correlation matrix
melted.cor.mat <- melt(cor.mat)
ggplot(melted.cor.mat, aes(x = X1, y = X2, fill = value)) + 
  geom_tile() +
  theme(axis.text.x = element_text(hjust=0.95, angle = 90, vjust = 0.5)) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1)) +
  geom_text(aes(x = X1, y = X2, label = value))




# Calculate the correlation matrix
cor_matrix <- cor(train)
cor_matrix

# Create the heatmap
heatmap(cor_matrix)

# Add a legend to the heatmap
legend("topright", legend = c("Negative", "Positive"), col = c("blue", "red"), pch = 15)



#Normalize data
str(train)
train.norm <- sapply(train[-c(1,2,26)], scale)
train.norm <- as.data.frame(train.norm)
train.norm$is.Satisfied <- train$is.Satisfied
str(train.norm)
summary(train.norm)


test.norm <- sapply(test[-c(1,2,26)], scale)
test.norm <- as.data.frame(test.norm)
test.norm$is.Satisfied <- test$is.Satisfied
str(test.norm)
summary(test.norm)


####### Classfication tree ########
library(rpart)
library(rpart.plot)
library(randomForest)
library(xgboost)
library(Matrix)
library(caret)
library(gains)

#removing x and id variables
train <- train[-c(1,2)]
test <- test[-c(1,2)]
#convert variable "is.satisfied" to categorical type
train$is.Satisfied <- as.factor(train$is.Satisfied)
test$is.Satisfied <- as.factor(test$is.Satisfied)

#fit a classification tree model
tr <- rpart(is.Satisfied ~ ., data = train, minbucket = 100, maxdepth = 7)
pfit<- prune(tr, cp = tr$cptable[which.min(tr$cptable[,"xerror"]),"CP"])
prp(tr)

t(t(names(train)))
#which are the most important variables
t(t(tr$variable.importance))

#set of rules
tr

#predictions on validation set
pred <- predict(tr, test[-c(1,2)])
head(pred[,2])
#confusion matrix
confusionMatrix(factor(1*(pred[,2]>0.5)), test$is.Satisfied, positive = "1")




###### KNN ##########



#reg on all variables
log_reg <- glm(is.Satisfied ~ ., data = 
                 train.norm, family = 'binomial')
options(scipen = 999)
summary(log_reg)





## Booking model
log_reg_b <- glm(is.Satisfied ~ ., data = 
                   subset(train.norm, select = c(Age,
                                                 is.Male,
                                                 is.Loyal,
                                                 is.Business,
                                                 is.BusinessClass,
                                                 is.EcoPlusClass,
                                                 is.Satisfied
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_b) 

# Age and Gender and insignificant for this model, plus, if this model is used
# to determine preferential treatment, then Age and Gender may be discriminatory

log_reg_b <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = c(is.Loyal,
                                            is.Business,
                                            is.BusinessClass,
                                            is.EcoPlusClass,
                                            is.Satisfied
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_b) #This is the final booking model

# Testing model
booking_pred <- predict(log_reg_b, subset(test, select = c(is.Loyal,
                                                           is.Business,
                                                           is.BusinessClass,
                                                           is.EcoPlusClass)), 
                        type = 'response')
head(booking_pred)
booking_pred_50 <- round(booking_pred, digits = 0) #Cut-off at 50%
head(booking_pred_50)

confusionMatrix(as.factor(booking_pred_50), as.factor(test$is.Satisfied),
                dnn = c('Prediction', 'Actuals')) 

#stepwise for all variables model
library(MASS)
stepwise1 <- stepAIC(log_reg, direction = "both")
options(scipen = 999)
summary(stepwise1)

#stepwise for booking model
stepwise2 <- stepAIC(log_reg_b, direction = "both")
options(scipen = 999)
summary(stepwise2)

#stepwise for follow up model
stepwise3 <- stepAIC(log_reg_f, direction = "both")
options(scipen = 999)
summary(stepwise3)

#stepwise for prescriptive model
stepwise4 <- stepAIC(log_reg_p, direction = "both")
options(scipen = 999)
summary(stepwise4)


## Prescriptive Model
log_reg_p <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = -c(X, 
                                             id, 
                                             Age, 
                                             Flight.Distance,
                                             Departure.Delay.in.Minutes,
                                             Arrival.Delay.in.Minutes,
                                             is.Male, 
                                             is.Loyal,
                                             is.Business,
                                             is.BusinessClass,
                                             is.EcoPlusClass
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_p) #in flight service is insignificant

log_reg_p <- glm(is.Satisfied ~ ., data = 
                   subset(train, select = -c(X, 
                                             id, 
                                             Age, 
                                             Flight.Distance,
                                             Departure.Delay.in.Minutes,
                                             Arrival.Delay.in.Minutes,
                                             is.Male, 
                                             is.Loyal,
                                             is.Business,
                                             is.BusinessClass,
                                             is.EcoPlusClass,
                                             Inflight.service
                   )) 
                 , family = 'binomial')
options(scipen = 999)
summary(log_reg_p)

# Testing model
prescriptive_pred <- predict(log_reg_p, subset(test, select = -c(X, 
                                                                 id, 
                                                                 Age, 
                                                                 Flight.Distance,
                                                                 Departure.Delay.in.Minutes,
                                                                 Arrival.Delay.in.Minutes,
                                                                 is.Male, 
                                                                 is.Loyal,
                                                                 is.Business,
                                                                 is.BusinessClass,
                                                                 is.EcoPlusClass,
                                                                 Inflight.service,
                                                                 is.Satisfied)), 
                             type = 'response')
head(prescriptive_pred)
prescriptive_pred_50 <- round(prescriptive_pred, digits = 0) #Cut-off at 50%
head(prescriptive_pred_50)

confusionMatrix(as.factor(prescriptive_pred_50), as.factor(test$is.Satisfied),
                dnn = c('Prediction', 'Actuals')) #Accuracy : 0.8134 

