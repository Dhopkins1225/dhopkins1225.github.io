# Airline Customer Satisfaction Analysis Project Summary

Welcome to the comprehensive summary of the Airline Customer Satisfaction Analysis Project. This project, conducted using R, focuses on unraveling the factors that influence passenger satisfaction in the airline industry, aiming to enhance the overall passenger experience through data-driven insights.

## Project Scope

The project encompasses several stages of data analysis, from initial data preparation and exploratory analysis to the application of advanced predictive modeling techniques. The core objective is to identify key drivers of customer satisfaction and pinpoint opportunities for service improvement.

## Analytical Methods Employed

### Data Preparation

Utilizing R's robust packages (`tidyr`, `dplyr`, etc.), the project begins with thorough data cleaning and preparation, transforming raw datasets into a structured format suitable for analysis.

### Predictive Modeling Techniques

The project leverages a trio of predictive modeling techniques to explore various aspects of customer satisfaction:

- **Logistic Regression**: Applied to develop models predicting satisfaction based on booking details, post-flight experiences, and in-flight services.
- **K-Nearest Neighbors (KNN)**: Utilized to model customer satisfaction with different configurations, adjusting for data peculiarities such as "too many ties" by employing the "brute" search algorithm.
- **Classification Trees**: Employed to identify the most influential variables affecting satisfaction, with models tailored to different stages of the customer journey and service aspects.

## Key Findings

- **Influential Factors**: The analysis highlights critical factors impacting satisfaction, including in-flight services, booking convenience, and operational aspects like delays.
- **Model Performance**:
  - **KNN** showed remarkable accuracy, particularly in the full model, with specific configurations optimized for different scenarios.
  - **Classification Trees** provided nuanced insights into variable importance across models, demonstrating notable accuracy.
  - **Logistic Regression** offered significant predictors across various models, with tailored adjustments enhancing model accuracy.

### Model Insights

- **KNN Analysis**: Achieved the highest overall accuracy in the full model, with specific neighbor configurations yielding optimal results for the booking, follow-up, and prescriptive models.
- **Classification Trees**: Emerged as the most effective method, especially for targeted models like booking and follow-up, by accurately identifying key variables.
- **Logistic Regression**: Provided a solid foundation for predictive analysis, with all variables showing significance and contributing to a comprehensive understanding of satisfaction drivers.

## Strategic Implications

The analysis underscores the complexity of customer satisfaction in the airline industry, suggesting a multifaceted approach to enhancing service quality. Classification trees, in particular, stood out for their ability to distill actionable insights from complex datasets.

## Future Directions

- **Data Enrichment**: Additional data collection is advocated, especially to refine the booking and follow-up models.
- **Demographic Analysis**: Further examination of passenger demographics could bolster the reliability and applicability of the predictive models.

## Conclusion

This project illustrates the power of combining different analytical methods to dissect and understand airline customer satisfaction. The findings not only highlight the critical areas for service enhancement but also pave the way for implementing targeted improvements based on predictive insights.

**Further Exploration**: For an in-depth review of the methodologies and detailed findings, please refer to the R scripts in the `/scripts/` directory of this repository.
