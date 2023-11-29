# Challengers Improving Delivery Service at Food Joint
The project aims to enhance business efficiency, customer satisfaction, and competitiveness by implementing KPI tracking systems for critical areas like order value, customer retention, and revenue growth.
# Delivery Time Prediction Model

## Overview

This project contains code for training and deploying a delivery time prediction model for a food delivery service. The model is built using R and leverages various machine learning libraries.

## Project Structure

- `data/`: Contains the dataset used for model training.
- `models/`: Stores the trained machine learning model.
- `src/`: Source code for data preprocessing, model training, and Plumber API setup.
- `plumber_api.R`: Plumber API file for serving the model predictions.

## Getting Started

### Prerequisites

- R installed (version X.X.X recommended)
- RStudio or any other R IDE
- Required R packages (install with `install.packages(c(""))`)

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/delivery-time-prediction.git
   cd delivery-time-prediction

2. Install Dependencies:
   
3. Train the Model:

   Rscript src/train_model.R

4. Run the Plumber API:

   Rscript plumber_api.R 

5. Test the API:

    curl -X POST -H "Content-Type: application/json" \
    -d '{"Delivery_person_Age": 25, "Delivery_person_Ratings": 4.5, ...}' \
    http://127.0.0.1:8000/predict  
