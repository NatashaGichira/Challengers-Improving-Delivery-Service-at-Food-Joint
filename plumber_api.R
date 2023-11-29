library(plumber)
library(glmnet)

model <- readRDS("linear_regression_model.rds")

predict_time_taken <- function(
  Delivery_person_Age, Delivery_person_Ratings, Restaurant_latitude,
  Restaurant_longitude, Delivery_location_latitude, Delivery_location_longitude,
  Order_Date, Weather_conditions, Road_traffic_density, Vehicle_condition,
  Type_of_order, Type_of_vehicle, multiple_deliveries, Festival, City
) {
  input_data <- data.frame(
    Delivery_person_Age, Delivery_person_Ratings, Restaurant_latitude,
    Restaurant_longitude, Delivery_location_latitude, Delivery_location_longitude,
    Order_Date, Weather_conditions, Road_traffic_density, Vehicle_condition,
    Type_of_order, Type_of_vehicle, multiple_deliveries, Festival, City
  )

  predictions <- predict(model, newdata = input_data)

  return(predictions)
}

plumber_api <- plumb("plumber_api.R")

plumber_api$run(port = 8000)