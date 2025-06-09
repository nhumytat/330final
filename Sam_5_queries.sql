use BGT_Billboards;
-- Q1: What was the total count of northbound cyclists and southbound pedestrians between 6am and 6pm on a specific day (June 9th)?

SELECT SUM(bike_north) AS TotalNorthboundCyclists, SUM(ped_south) AS TotalSouthboundPedestrians
FROM Sensor_Reading
WHERE timestamp >= '2025-06-09 06:00:00' AND timestamp < '2025-06-09 18:00:00';

-- Q2: What percentage of total traffic in a Seattle Center during peak evening commute (4pm - 6pm) is pedestrian versus cyclist?

SELECT b.neighborhood, SUM(SR.ped_south + SR.ped_north) AS TotalPedestrianTraffic, SUM(SR.bike_south + SR.bike_north) AS TotalCyclistTraffic,
    (
        SUM(SR.ped_south + SR.ped_north) * 100.0 / SUM(SR.ped_south + SR.ped_north + SR.bike_south + SR.bike_north)
    ) AS PedestrianPercentage,

    (
        SUM(SR.bike_south + SR.bike_north) * 100.0 / SUM(SR.ped_south + SR.ped_north + SR.bike_south + SR.bike_north)
    ) AS CyclistPercentage
FROM Sensor_Reading AS sr
JOIN Billboard AS b ON sr.sensor_id = b.sensor_id
WHERE b.neighborhood = 'Seattle Center' AND DATEPART(hour, sr.timestamp) BETWEEN 16 AND 18
GROUP BY b.neighborhood;

-- Q3: Rank all organizations by their total spending on bookings

SELECT O.org_name, SUM(B.quote_price) AS TotalSpending, RANK() OVER (ORDER BY SUM(B.quote_price) DESC) AS SpendingRank
FROM Booking AS b
JOIN Content AS c ON b.content_id = c.content_id
JOIN Organization AS o ON c.org_id = o.org_id
GROUP BY o.org_name
ORDER BY SpendingRank;

-- Q4: List pairs of bookings that are for the same billboard and by the same organization, where one booking starts on the same day the previous one ends.

SELECT o.org_name, bb.neighborhood, b1.booking_id, b1.end_datetime, b2.booking_id, b2.start_datetime
FROM Booking AS b1
JOIN Booking AS b2 ON b1.billboard_id = b2.billboard_id AND b1.booking_id <> b2.booking_id
JOIN Content AS c1 ON b1.content_id = c1.content_id
JOIN Content AS c2 ON b2.content_id = c2.content_id
JOIN Organization AS o ON c1.org_id = o.org_id
JOIN Billboard AS bb ON b1.billboard_id = bb.billboard_id
WHERE c1.org_id = c2.org_id AND B2.start_datetime = B1.end_datetime;

-- Q5: Which specific hour on June 8th had the absolute highest combined count of pedestrians and cyclists?

WITH RankedTraffic AS (
    SELECT DATEPART(hour, timestamp) AS HourOfDay, SUM(ped_south + ped_north + bike_south + bike_north) AS TotalTraffic, 
    RANK() OVER (ORDER BY SUM(ped_south + ped_north + bike_south + bike_north) DESC) as TrafficRank
    FROM Sensor_Reading
    WHERE CAST(timestamp AS DATE) = '2025-06-08'
    GROUP BY DATEPART(hour, timestamp)
)
SELECT HourOfDay AS BusiestHour, TotalTraffic
FROM RankedTraffic
WHERE TrafficRank = 1;
