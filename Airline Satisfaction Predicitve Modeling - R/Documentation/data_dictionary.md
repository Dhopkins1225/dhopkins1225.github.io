
# Data Dictionary


## The dataset has been organized to facilitate analysis of factors affecting airline customer satisfaction.

## Variables

### Passenger Information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| Gender | VARCHAR | Gender of the passengers ('Female', 'Male'). |
| Customer_Type | VARCHAR | Type of customer ('Loyal customer', 'Disloyal customer'). |
| Age | INT | Actual age of the passengers. |
| Type_of_Travel | VARCHAR | Purpose of the flight ('Personal Travel', 'Business Travel'). |
| Class | VARCHAR | Class of travel on the plane ('Business', 'Eco', 'Eco Plus'). |

### Flight Information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| Flight_Distance | INT | Distance of the flight journey. |
| Inflight_wifi_service | TINYINT | Satisfaction with inflight wifi (0: NA; 1-5: Satisfaction level). |
| Departure_Arrival_time_convenient | TINYINT | Satisfaction with time convenience of departure/arrival. |
| Ease_of_Online_booking | TINYINT | Satisfaction with the ease of online booking. |
| Gate_location | TINYINT | Satisfaction with the gate location. |

### Service Quality

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| Food_and_drink | TINYINT | Satisfaction with the food and drink. |
| Online_boarding | TINYINT | Satisfaction with online boarding. |
| Seat_comfort | TINYINT | Satisfaction with seat comfort. |
| Inflight_entertainment | TINYINT | Satisfaction with inflight entertainment. |
| On_board_service | TINYINT | Satisfaction with on-board service. |
| Leg_room_service | TINYINT | Satisfaction with leg room service. |
| Baggage_handling | TINYINT | Satisfaction with baggage handling. |
| Check_in_service | TINYINT | Satisfaction with check-in service. |
| Inflight_service | TINYINT | Satisfaction with inflight service. |
| Cleanliness | TINYINT | Satisfaction with cleanliness. |

### Travel Experience

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| Departure_Delay_in_Minutes | INT | Minutes delayed at departure. |
| Arrival_Delay_in_Minutes | INT | Minutes delayed at arrival. |
| Satisfaction | VARCHAR | Overall satisfaction ('Satisfaction', 'Neutral', 'Dissatisfaction'). |
