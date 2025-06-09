-- Q1: What was the total count of northbound cyclists and southbound pedestrians between 6am and 6pm?

SELECT SUM(bike_north) AS TotalNorthboundCyclists, SUM(ped_south) AS TotalSouthboundPedestrians
FROM Sensor_Reading
WHERE timestamp >= '2025-06-09 06:00:00' AND timestamp < '2025-06-09 18:00:00';

-- Q2: What percentage of total traffic at a specific billboard during peak evening commute is pedestrian versus cyclist?

SELECT b.neighborhood, SUM(SR.ped_south + SR.ped_north) AS TotalPedestrianTraffic, SUM(SR.bike_south + SR.bike_north) AS TotalCyclistTraffic,
    (
        SUM(SR.ped_south + SR.ped_north) * 100.0 / SUM(SR.ped_south + SR.ped_north + SR.bike_south + SR.bike_north)
    ) AS PedestrianPercentage,

    (
        SUM(SR.bike_south + SR.bike_north) * 100.0 / SUM(SR.ped_south + SR.ped_north + SR.bike_south + SR.bike_north)
    ) AS CyclistPercentage
FROM Sensor_Reading AS sr
JOIN Billboard AS b ON sr.sensor_id = b.sensor_id
WHERE b.neighborhood = 'Seattle Center' AND DATEPART(hour, sr.timestamp) BETWEEN 16 AND 17
GROUP BY b.neighborhood;

-- Q3: Rank all organizations by their total spending on bookings

SELECT O.org_name, SUM(B.quote_price) AS TotalSpending, RANK() OVER (ORDER BY SUM(B.quote_price) DESC) AS SpendingRank
FROM Booking AS b
JOIN Content AS c ON b.content_id = c.content_id
JOIN Organization AS o ON c.org_id = o.org_id
GROUP BY o.org_name
ORDER BY SpendingRank;

-- Q4: List all active bookings for "Public Service Announcement" content

SELECT b.booking_id, o.org_name, c.description, bb.neighborhood, b.start_datetime, b.end_datetime
FROM Booking AS b
JOIN Content AS c ON b.content_id = c.content_id
JOIN Organization AS o ON c.org_id = o.org_id
JOIN Billboard AS bb ON b.billboard_id = bb.billboard_id
WHERE c.type = 'Public Service Announcement'

-- Q5: Which specific hour on a given day had the absolute highest combined count of pedestrians and cyclists?

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
