# Airline Customer Satisfaction Analysis Project

Welcome to the Airline Customer Satisfaction Analysis Project repository! This project leverages R programming to deeply analyze airline customer satisfaction, focusing on predictive modeling to understand and enhance the passenger experience.

## Project Overview

This initiative employs data preparation, exploratory data analysis (EDA), logistic regression, and predictive analytics techniques. The goal is to pinpoint critical factors that influence customer satisfaction and identify areas for service improvement within the airline industry.

## Environment Setup

The analysis harnesses the power of R and several essential packages:

- `tidyr` for data cleaning,
- `forecast` for time series analysis,
- `dplyr` for data manipulation,
- `caret` for modeling and prediction.

## Data Preparation and Cleaning

Data is meticulously prepared through the following processes:

- Loading from `train.csv` and `test.csv`.
- NA values are eliminated to ensure data integrity.
- Transformation of categorical variables into dummy variables for analytical readiness.

## Logistic Regression Analysis

The project constructs several logistic regression models to predict customer satisfaction:

- **Booking Model**: Determines satisfaction likelihood at booking, leveraging variables like loyalty status, business travel, and class of service.
- **Follow-up Model**: Incorporates variables like departure and arrival delays to predict post-flight satisfaction.
- **Prescriptive Model**: Targets in-flight and operational services to recommend enhancements.

## Insights and Findings

- Significant factors impacting customer satisfaction are highlighted.
- Recommendations are provided on which airline services should be improved to boost satisfaction levels.
- Models are evaluated for their predictive performance, offering insights into their effectiveness.

## Models and Predictive Analytics

- **Booking and Follow-up Models**: Utilize logistic regression for early satisfaction prediction, facilitating proactive engagement strategies.
- **Prescriptive Model**: Guides airline service prioritization for customer satisfaction improvement.

## Additional Analyses

- Evaluation of model accuracy through misclassification rates.
- Exploration of dimension reduction and classification trees for enriched insights.
- Application of correlation heatmaps and data normalization for a comprehensive data understanding.

This repository includes all necessary scripts, data files, and documentation for a full comprehension and replication of the analysis, providing a robust framework for exploring airline customer satisfaction through data-driven methodologies.

## Results Summary

### KNN Analysis
- **Full Model**: Achieved the highest accuracy at 96.59% with k = 5.
- **Booking Model**: Best accuracy at 77.69% with k = 4.
- **Follow-Up Model**: Revealed 76.56% accuracy with k = 22.
- **Prescriptive Model**: Attained 91.80% accuracy with k = 7.
- A cutoff of 50% was consistently used across all KNN models.

### Classification Trees
- **Full Model**: Demonstrated 88.40% accuracy.
- **Booking and Follow-Up Models**: Both showed 77.90% accuracy, with 14% false negatives and 9% false positives.
- **Prescriptive Model**: Exhibited 86.20% accuracy, with 8% false negatives and 6% false positives.
- All models used a cutoff of 50%.

### Logistic Regression
- **Full Model**: Excluded Flight Distance, all variables significant (p < 0.05).
- **Booking Model**: All predictors significant with 77.91% accuracy.
- **Follow-Up Model**: Achieved 78.16% accuracy, all variables significant.
- **Prescriptive Model**: Presented 81.34% accuracy, with all variables significant.

### Choosing the Best Method
Classification trees emerged as the most effective method for the booking, follow-up, and prescriptive models, despite KNN showing higher performance in the full model analysis.

## Conclusions

- **Effectiveness of Classification Trees**: Proved to be the most accurate method, especially for booking and follow-up models.
- **Importance of Variables**: Similar key variables influenced both booking and follow-up model accuracies, suggesting a need for additional differentiating factors.
- **Misclassification Insights**: Higher false negatives in the booking and follow-up models indicate a tendency to underestimate passenger satisfaction.
- **Prescriptive Model's Superiority**: Demonstrated the highest accuracy among classification models, with a balanced rate of false negatives and positives.
- **Future Recommendations**: Additional data collection is recommended to enhance model accuracy, particularly for booking and follow-up scenarios. The analysis also highlights the importance of assessing passenger demographics to ensure model reliability.

This project underscores the complex nature of predicting airline customer satisfaction and the potential of classification trees in providing actionable insights. Despite expectations around logistic regression, the adaptability of classification trees to the data proved more decisive in accuracy. Future analyses could benefit from a broader dataset encompassing a more diverse passenger demographic to further refine and validate the models.


**Note**: For a detailed exploration of the methodologies and findings, please refer to the R scripts located in the `/scripts/` directory of this repository.
