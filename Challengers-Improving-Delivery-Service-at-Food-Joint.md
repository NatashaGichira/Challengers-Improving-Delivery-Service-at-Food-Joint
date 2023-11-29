# Model Training Process

## Introduction
This document provides an overview of the process involved in training a machine learning model for predicting delivery time in the context of a food delivery service. The model is trained using the R programming language and leverages the `glmnet` package.

## Steps

### 1. Load Libraries
```R
library(glmnet)
library(dplyr)
library(readr)
library(lubridate)
library(caret)
library(ggplot2)
library(tidyverse)
library(fastDummies)
library(corrplot)
library(dplyr)
library(workflows)
library(recipes)
library(yardstick)

### 2. Load Dataset

# Read CSV file into a data frame
data <- read_csv("data/finalTrain.csv")

### 3. Data Preprocessing

# Identify numeric features
numeric_features <- sapply(X, is.numeric)

# Create a pre-processing recipe
preprocess_recipe <- preProcess(X, method = c("medianImpute", "center", "scale"), y = TRUE)

# Apply the recipe to the data
preprocessed_data <- predict(preprocess_recipe, newdata = X)

# Combine preprocessed numerical and categorical data
preprocessed_data <- cbind(preprocessed_data, y)


### 4. Fit the glmnet model
model <- glmnet(X_train, y_train)

### 5. Model evaluation

for (i in seq_along(models)) {
  model <- models[[i]]

  # Ensure that y_test contains the column "y_test"
  if ("y_test" %in% colnames(y_test)) {
    # Make predictions
    y_pred <- predict(model, newdata = X_test)

    # Combine true values and predicted values
    results <- data.frame(True = y_test$y_test, Pred = y_pred)

    # Remove rows with missing values
    results <- na.omit(results)

    # Evaluate the model
    metrics <- evaluate_model(results$True, results$Pred)

    # Print results
    cat(names(models)[i], "\n")
    cat("Model Training Performance\n")
    cat("RMSE: ", metrics["RMSE"], "\n")
    cat("MAE: ", metrics["MAE"], "\n")
    cat("R2 Score: ", metrics["R2_Square"] * 100, "\n")
    cat("=" * 100, "\n")

    # Store model name and R2 score
    model_list[i] <- names(models)[i]
    r2_list[i] <- metrics["R2_Square"]
  } else {
    cat("Column 'y_test' not found in y_test.\n")
  }
}

# 6. Save the trained model for future use
saveRDS(model, "linear_regression_model.rds")


## Conclusion

#The model training process involves loading data, preprocessing, training the model, evaluating its performance, and saving it for deployment. This trained model can be used to predict delivery times in real-world scenarios.
