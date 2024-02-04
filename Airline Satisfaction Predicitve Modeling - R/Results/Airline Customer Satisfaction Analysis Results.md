# Airline Customer Satisfaction Analysis Project Results

## Data Mining Tasks and Models

This project assessed four models using K-Nearest Neighbors (KNN), Classification Trees, and Logistic Regression: Full model, Booking model, Follow-up model, and Prescriptive model. The goal was to enhance customer satisfaction through predictive and prescriptive analytics.

### Overview of Models

1. **Full Model**: Assessed all predictor variables to formulate policies improving future customer satisfaction. Variables include in-flight services, booking convenience, and delays.
2. **Booking Model**: Predicts satisfaction likelihood at the booking stage, employing variables such as loyalty status and travel class.
3. **Follow-Up Model**: Assigns satisfaction likelihood post-flight, including delay variables to proactively manage customer dissatisfaction.
4. **Prescriptive Model**: Identifies service improvement areas, excluding variables like Age, Flight Distance, and specific customer demographics.

## Methodologies

### K-Nearest Neighbors (KNN)

Encountering "too many ties" suggested equal distances among numerous data points, requiring the "brute" algorithm for resolution.

- **Full Model**: Achieved 96.59% accuracy with `k = 5`.
- **Booking Model**: `k = 4` reached 77.69% accuracy.
- **Follow-Up Model**: `k = 22` showed 76.56% accuracy.
- **Prescriptive Model**: `k = 7` led to 91.80% accuracy.

### Classification Trees

Evaluated the importance of various predictors across models with different accuracies.

- **Full Model**: Key variables included online boarding and in-flight entertainment, with 88.4% accuracy.
- **Booking Model**: Focused on business class, loyalty, and business travel, achieving 77.9% accuracy.
- **Follow-Up Model**: Mirrored the Booking Model in variables and accuracy (77.9%).
- **Prescriptive Model**: Highlighted online boarding, Wi-Fi service, and seat comfort among others, reaching 86.2% accuracy.

### Logistic Regression

Adjusted models based on variable significance, achieving varying accuracies.

- **Full Model**: Excluded Flight Distance due to insignificance, attaining 77.91% accuracy.
- **Booking Model**: Omitted Age and Gender for ethical considerations, achieving 78% accuracy.
- **Follow-Up Model**: Incorporated delays, with 78% accuracy at a 50% cutoff.
- **Prescriptive Model**: Dropped 'In-flight Services' for irrelevance, achieving 81% accuracy.

## Conclusions

The project's multifaceted approach, through KNN, Classification Trees, and Logistic Regression, provided a comprehensive analysis across booking, follow-up, and prescriptive dimensions. Each method contributed uniquely to understanding and enhancing airline customer satisfaction, showcasing the importance of tailored analytics in predictive and prescriptive decision-making.
