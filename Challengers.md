Business Intelligence Project
================
Challengers Team
20th November 2023

- [Student Details](#student-details)
  - [Read Data](#read-data)
  - [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
    - [Missing Values](#missing-values)
    - [Drop Unnecessary Columns](#drop-unnecessary-columns)
  - [Data Visualization](#data-visualization)
    - [Histogram Plot Function](#histogram-plot-function)
    - [Fill Missing Values](#fill-missing-values)
    - [Filtering and Removing Rows](#filtering-and-removing-rows)
    - [Column Information](#column-information)
    - [Data Integrity Check](#data-integrity-check)
    - [Additional Visualizations](#additional-visualizations)
  - [Data Summary](#data-summary)
    - [Fill Missing Values (Continued)](#fill-missing-values-continued)
    - [Duplicate Rows](#duplicate-rows)
    - [Missing Values Percentage](#missing-values-percentage)

------------------------------------------------------------------------

# Student Details

<table style="width:61%;">
<colgroup>
<col style="width: 19%" />
<col style="width: 41%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>Student ID Numbers and Names of Group Members</strong></td>
<td><ol type="1">
<li>124255 - Natasha Gichira</li>
<li>120415 - Emmanuel Agre</li>
<li>118211 - Fredrick Koech</li>
<li>124562 - Ryan Munene</li>
<li>124422 - Dennis Muriuki</li>
</ol></td>
</tr>
<tr class="even">
<td><strong>GitHub Classroom Group Name</strong></td>
<td>Challengers Team</td>
</tr>
<tr class="odd">
<td><strong>Course Code</strong></td>
<td>BBT4206</td>
</tr>
<tr class="even">
<td><strong>Course Name</strong></td>
<td>Business Intelligence II</td>
</tr>
<tr class="odd">
<td><ul>
<li>Program</li>
</ul></td>
<td>Bachelor of Business Information Technology</td>
</tr>
<tr class="even">
<td><strong>Semester Duration</strong></td>
<td>21<sup>st</sup> August 2023 to 28<sup>th</sup> November 2023</td>
</tr>
</tbody>
</table>

``` markdown
# R Code Analysis and Preprocessing

## Install and load required libraries
```R
install.packages("dplyr")
library(dplyr)

install.packages("ggplot2")
library(ggplot2)
```

## Read Data

``` r
# Read data from CSV file
data <- read.csv("data/finalTrain.csv")

# Check first few rows of the data
head(data, 3)
```

## Exploratory Data Analysis (EDA)

### Missing Values

``` r
# Check rows with missing values in "Delivery_person_Age"
head(data[is.na(data$Delivery_person_Age)], 3)

# Check the data types and number of non-null values for each column
summary(data)
```

### Drop Unnecessary Columns

``` r
# Drop columns with no information or unique values
data <- data %>% select(-Delivery_person_ID, -ID, -Time_Orderd, -Time_Order_picked)

# Check the data types and number of non-null values for each column after dropping columns
summary(data)
```

## Data Visualization

### Histogram Plot Function

``` r
# Define a function to plot histograms with density curves
histplotcount_func <- function(input_feature, data, no_of_bins) {
  ggplot(data, aes(x = input_feature)) +
    geom_histogram(bins = no_of_bins) +
    stat_density(geom = "line", color = "blue") +
    labs(title = paste("Distribution of", input_feature), x = input_feature, y = "Frequency") +
    theme_bw()

  # Show the plot
  print(ggplot2::last_plot())
}

# Plot histogram with density curve for "Delivery_person_Age"
histplotcount_func("Delivery_person_Age", data, 5)
```

### Fill Missing Values

``` r
# Calculate the mean of "Delivery_person_Age" to fill missing values
mean_age <- mean(data$Delivery_person_Age)

# Fill missing values in "Delivery_person_Age" with the mean
data$Delivery_person_Age <- replace(data$Delivery_person_Age, is.na(data$Delivery_person_Age), mean_age)

# Check the distribution of "Delivery_person_Ratings"
data$Delivery_person_Ratings %>% count()
```

### Filtering and Removing Rows

``` r
# Remove rows where "Delivery_person_Ratings" is 6
data <- data %>% filter(Delivery_person_Ratings != 6)

# Plot histogram with density curve for "Delivery_person_Ratings"
histplotcount_func("Delivery_person_Ratings", data, 5)
```

### Column Information

``` r
# Loop through each column in the DataFrame and print information about each column
for (i in colnames(data)) {
  print(paste0("Column Name: ", i))
  print(paste0("Column Type: ", typeof(data[[i]])))
  print(rep("=", 64))

  # Print unique values in the column
  unique_values <- unique(data[[i]])
  print(unique_values)
  print(rep("=", 64))
}
```

### Data Integrity Check

``` r
# Count the number of records with zero values in "Delivery_location_latitude"
count_zero_latitude <- sum(data$Delivery_location_latitude == 0)
print(paste0("Number of records with Delivery_location_latitude equal to 0: ", count_zero_latitude))

# Count the number of records with zero values in "Restaurant_latitude"
count_zero_latitude <- sum(data$Restaurant_latitude == 0)
print(paste0("Number of records with Restaurant_latitude equal to 0: ", count_zero_latitude))

# Count the number of records with zero values in "Restaurant_longitude"
count_zero_longitude <- sum(data$Restaurant_longitude == 0)
print(paste0("Number of records with Restaurant_longitude equal to 0: ", count_zero_longitude))
```

### Additional Visualizations

``` r
# Plot histogram with density curve for "Restaurant_latitude"
histplotcount_func("Restaurant_latitude", data, 5)

# Plot histogram with density curve for "Restaurant_longitude"
histplotcount_func("Restaurant_longitude", data, 5)
```

## Data Summary

``` r
# Check the data types and number of non-null values for each column again
summary(data)
```

### Fill Missing Values (Continued)

``` r
# Calculate the median of "Delivery_location_longitude" to fill missing values
median_Delivery_location_longitude <- median(data$Delivery_location_longitude)

# Fill missing values in "Delivery_location_longitude" with the median
data$Delivery_location_longitude <- replace(data$Delivery_location_longitude, is.na(data$Delivery_location_longitude), median_Delivery_location_longitude)

# Calculate the median of "Delivery_location_latitude" to fill missing values
median_Delivery_location_latitude <- median(data$Delivery_location_latitude)

# Fill missing values in "Delivery_location_latitude" with the median
data$Delivery_location_latitude <- replace(data$Delivery_location_latitude, is.na(data$Delivery_location_latitude), median_Delivery_location_latitude)
```

### Duplicate Rows

``` r
# Check for duplicate rows
duplicate_rows <- data[duplicated(data)]

# Check the number of rows with and without duplicates
data.shape

# Calculate the percentage of rows with duplicates
percentage_duplicates <- (data.shape[0] - without_nan[0]) / data.shape[0] * 100
print(paste0("Percentage of rows with duplicates: ", round(percentage_duplicates, 2), "%"))
```

### Missing Values Percentage

\`\`\`R \# Calculate the percentage of missing values in the dataset
missing_values_percentage \<- (with_nan\[0\] - without_nan\[0\]) /
with_nan\[
