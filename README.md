Adaptive Intersections: Smart Advertising and Public Safety

1) Business Scenario
Our database will serve the marketing & advertising industries. We aim to help companies choose the optimal time to display their advertisements on a billboard located on the Burke-Gillman trail. 
Pedestrian and cyclist traffic volume data will be stored and utilized to reveal peak hours and patterns in traffic flow over time. The usage of a database helps to identify trends, maximize profits, and differentiate timeslots.
With a structured database, advertisers will be able to decide when to schedule advertisements based upon traffic volume, and the price of time slots can be determined based upon their traffic volumes. The billboard can be placed where it receives the most traffic. (For instance, people going north or south.)

2) Typical Users: 
The users who will be accessing this data are potential partners of our adaptive intersections. This will mainly include marketing partners that have an interest in displaying their advertisements on our dynamic billboards, and would like to query stats to optimize traffic for their advertisements. This could also be used by local authorities to be able to effectively display public safety alerts at key times, or activist groups that are interested in posting live stats of pedestrians and bicycle traffic to promote ecologically sustainable transportation. 
Since the data is automatically updated by the sensors, the users will not be updating the data directly. They will be able to query it however, and use the information gathered by the sensors in the database to make key business decisions.

3) Data Source:
We will primarily use the “Burke Gilman Trail (BGT) north of NE 70th St Bicycle and Pedestrian Counter” public dataset from the Seattle Open Data Portal. This dataset tracks the number of bicyclists and pedestrians heading North and South in one hour. Sensors are used to count passerbys, detect the hour and day that object(s) are detected, and capture the direction of travel (North or South). Columns include Date, Total, Ped South, Ped North, Bike South, and Bike North. We plan to supplement this with additional data on automobile traffic counts at BGT North of NE 70th St, joining by the “date and hour” field. While the Seattle Open Data portal has similar traffic counter datasets, most of them seem not to track count by the hour. If we are unable to find a suitable real dataset, we plan to create synthetic data based on existing traffic counter datasets to ensure realism.
