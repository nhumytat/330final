USE BGT_Billboards;

-- DROP TABLE IF EXISTS Sensor_Reading;
-- DROP TABLE IF EXISTS Booking;
-- DROP TABLE IF EXISTS Billboard;
-- DROP TABLE IF EXISTS Content;
-- DROP TABLE IF EXISTS Organization;


CREATE TABLE Organization (
    org_id INT PRIMARY KEY,
    type NVARCHAR(50),
    org_name NVARCHAR(500)
);

CREATE TABLE Content (
    content_id INT PRIMARY KEY,
    type NVARCHAR(50),
    description NVARCHAR(500),
    org_id INT,
    FOREIGN KEY (org_id) REFERENCES Organization(org_id)
);

CREATE TABLE Billboard (
    billboard_id INT PRIMARY KEY,
    latitude DECIMAL(8,6),
    longitude DECIMAL(9,6),
    neighborhood NVARCHAR(100),
    sensor_id INT NOT NULL UNIQUE,
    sensor_type NVARCHAR(50)
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    quote_price DECIMAL(6,2),
    start_datetime DATETIME2,
    end_datetime DATETIME2,
    content_id INT,
    billboard_id INT,
    FOREIGN KEY (content_id) REFERENCES Content(content_id),
    FOREIGN KEY (billboard_id) REFERENCES Billboard(billboard_id),
    CHECK (
        DATEPART(MINUTE, start_datetime) = 0 AND
        DATEPART(SECOND, start_datetime) = 0 AND
        DATEPART(NANOSECOND, start_datetime) = 0
    ),
    CHECK (
        DATEPART(MINUTE, end_datetime) = 0 AND
        DATEPART(SECOND, end_datetime) = 0 AND
        DATEPART(NANOSECOND, end_datetime) = 0
    )
);

CREATE TABLE Sensor_Reading (
    timestamp DATETIME2,
    ped_south INT,
    ped_north INT,
    bike_south INT,
    bike_north INT,
    sensor_id INT,
    FOREIGN KEY (sensor_id) REFERENCES Billboard(sensor_id),
    PRIMARY KEY (timestamp, sensor_id)
);

INSERT INTO Organization (org_id, type, org_name) VALUES
(101, 'Commercial', 'Emerald City Coffee Roasters'),
(102, 'Non-Profit', 'Puget Sound Cleanup Alliance'),
(103, 'Government', 'Seattle Department of Transportation'),
(104, 'Commercial', 'Space Needle Souvenirs'),
(105, 'Commercial', 'Pike Place Fish Market Online'),
(106, 'Non-Profit', 'Seattle Parks Foundation'),
(107, 'Government', 'King County Metro'),
(108, 'Commercial', 'Cascade Bicycle Club'),
(109, 'Non-Profit', 'MoPOP (Museum of Pop Culture)'),
(110, 'Commercial', 'Theo Chocolate');

INSERT INTO Content (content_id, type, description, org_id) VALUES
(201, 'Advertisement', 'Ad for a new line of dark roast coffee beans.', 101),
(202, 'Public Service Announcement', 'PSA about a beach cleanup event next month.', 102),
(203, 'Advertisement', 'Follow-up ad for the coffee roasters.', 101),
(204, 'Informational', 'Safety message about sharing the road with cyclists.', 103),
(205, 'Advertisement', 'Get your official Space Needle miniature!', 104),
(206, 'Advertisement', 'Fresh fish delivered to your door.', 105),
(207, 'Public Service Announcement', 'Support your local parks. Donate today.', 106),
(208, 'Informational', 'New bus route changes effective July 1st.', 107),
(209, 'Event', 'Sign up for the annual Seattle to Portland bike ride.', 108),
(210, 'Exhibition', 'New Marvel exhibit now open at MoPOP.', 109),
(211, 'Advertisement', 'Taste our new organic dark chocolate bar.', 110);

INSERT INTO Billboard (billboard_id, latitude, longitude, neighborhood, sensor_id, sensor_type) VALUES
(1, 47.6229, -122.3223, 'Capitol Hill', 501, 'Pedestrian/Bike Counter'),
(2, 47.6538, -122.3500, 'Fremont', 502, 'Pedestrian/Bike Counter'),
(3, 47.6080, -122.3351, 'Downtown', 503, 'Pedestrian/Bike Counter'),
(4, 47.6205, -122.3493, 'Seattle Center', 504, 'Pedestrian/Bike Counter'),
(5, 47.6097, -122.3422, 'Pike Place Market', 505, 'Pedestrian/Bike Counter'),
(6, 47.6613, -122.3130, 'University District', 506, 'Pedestrian/Bike Counter'),
(7, 47.5513, -122.2965, 'Columbia City', 507, 'Pedestrian Counter'),
(8, 47.6800, -122.3850, 'Ballard', 508, 'Pedestrian/Bike Counter'),
(9, 47.5457, -122.3845, 'West Seattle', 509, 'Pedestrian Counter'),
(10, 47.6145, -122.3145, 'First Hill', 510, 'Pedestrian/Bike Counter');

INSERT INTO Sensor_Reading (timestamp, ped_south, ped_north, bike_south, bike_north, sensor_id) VALUES
('2025-06-08 14:00:00', 150, 165, 30, 25, 501), -- Capitol Hill
('2025-06-08 14:00:00', 210, 190, 45, 55, 502), -- Fremont
('2025-06-08 15:00:00', 145, 170, 28, 22, 501),
('2025-06-08 15:00:00', 350, 375, 80, 75, 503), -- Downtown
('2025-06-08 16:00:00', 450, 475, 90, 85, 504), -- Seattle Center
('2025-06-08 16:00:00', 550, 525, 15, 20, 505), -- Pike Place
('2025-06-09 09:00:00', 120, 130, 60, 65, 506), -- U-District
('2025-06-09 09:00:00', 90, 85, 0, 0, 507),     -- Columbia City (Ped only)
('2025-06-09 10:00:00', 180, 200, 70, 75, 508), -- Ballard
('2025-06-09 10:00:00', 110, 100, 0, 0, 509);   -- West Seattle (Ped only)

INSERT INTO Booking (booking_id, quote_price, start_datetime, end_datetime, content_id, billboard_id) VALUES
(1001, 750.00, '2025-06-10 09:00:00', '2025-06-17 09:00:00', 201, 1), -- Coffee ad on Capitol Hill
(1002, 500.50, '2025-06-12 12:00:00', '2025-06-19 12:00:00', 202, 2), -- PSA in Fremont
(1003, 950.00, '2025-07-01 00:00:00', '2025-07-08 00:00:00', 204, 3), -- SDOT message Downtown
(1004, 800.00, '2025-06-20 10:00:00', '2025-06-27 10:00:00', 205, 4), -- Souvenirs ad at Seattle Center
(1005, 900.00, '2025-06-22 11:00:00', '2025-06-29 11:00:00', 206, 5), -- Fish Market ad at Pike Place
(1006, 450.00, '2025-07-05 08:00:00', '2025-07-12 08:00:00', 207, 6), -- Parks PSA in U-District
(1007, 650.00, '2025-07-10 12:00:00', '2025-07-17 12:00:00', 208, 7), -- Metro ad in Columbia City
(1008, 700.00, '2025-07-15 14:00:00', '2025-07-22 14:00:00', 209, 8), -- Bike ad in Ballard
(1009, 850.00, '2025-08-01 10:00:00', '2025-08-08 10:00:00', 210, 4), -- MoPOP ad at Seattle Center
(1010, 725.00, '2025-08-05 18:00:00', '2025-08-12 18:00:00', 211, 10); -- Theo Chocolate ad on First Hill

-- SELECT * FROM Organization;
-- SELECT * FROM Content;
-- SELECT * FROM Billboard;
-- SELECT * FROM Sensor_Reading;
-- SELECT * FROM Booking;
