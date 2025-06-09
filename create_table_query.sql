USE BGT_Billboards;

DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS Content;
DROP TABLE IF EXISTS Billboard;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Sensor_Reading;

CREATE TABLE Organization (
    org_id INT PRIMARY KEY,
    type NVARCHAR(50),
    org_name NVARCHAR(500)
);

CREATE TABLE Content (
    content_id INT PRIMARY KEY,
    type NVARCHAR(50),
    description NVARCHAR(500),
    org_id INT FOREIGN KEY REFERENCES Organization(org_id)
);

CREATE TABLE Billboard (
    billboard_id INT PRIMARY KEY,
    latitude DECIMAL(8,6),
    longitude DECIMAL (9,6),
    neighborhood NVARCHAR(100),
    sensor_id INT NOT NULL UNIQUE
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY ,
    quote_price DECIMAL (6,2),
    start_datetime DATETIME2,
    end_datetime DATETIME2,
    content_id INT FOREIGN KEY REFERENCES Content(content_id),
    billboard_id INT FOREIGN KEY REFERENCES Billboard(billboard_id),
    CHECK (DATEPART(MINUTE, start_datetime) = 0 AND DATEPART(SECOND, start_datetime) = 0 AND DATEPART(NANOSECOND, start_datetime) = 0),
    CHECK (DATEPART(MINUTE, end_datetime) = 0 AND DATEPART(SECOND, end_datetime) = 0 AND DATEPART(NANOSECOND, end_datetime) = 0)
);

CREATE TABLE Sensor_Reading (
    timestamp DATETIME2,
    ped_south INT,
    ped_north INT,
    bike_south INT,
    bike_north INT,
    sensor_id INT FOREIGN KEY REFERENCES Billboard(sensor_id),
    booking_id INT FOREIGN KEY REFERENCES Booking(booking_id),
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
(110, 'Commercial', 'Theo Chocolate'),
(201, 'Non-Profit', 'Clean Air Coalition'),
(202, 'Non-Profit', 'Bike Safety Alliance');

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
(211, 'Advertisement', 'Taste our new organic dark chocolate bar.', 110),
(212, 'Advertisement', 'Limited edition cold brew bottles for summer.', 101),
(213, 'Advertisement', 'Now hiring baristas in your neighborhood.', 101),
(214, 'Public Service Announcement', 'Join our Orca habitat restoration project.', 102),
(215, 'Public Service Announcement', 'Beach cleanup event this Saturday!', 102),
(216, 'Informational', 'New protected bike lanes installed downtown.', 103),
(217, 'Informational', 'Light rail expansion updates coming soon.', 103),
(218, 'Advertisement', 'Buy one, get one free on Space Needle mugs!', 104),
(219, 'Advertisement', 'Free delivery on fresh seafood orders over $50.', 105),
(220, 'Public Service Announcement', 'Volunteer for our summer trail building crew.', 106),
(221, 'Informational', 'Fare-free weekends during June & July.', 107),
(222, 'Event', 'Register now for the summer night ride through Seattle.', 108),
(223, 'Exhibition', 'Indie Game Revolution: The Soundtrack Exhibit.', 109),
(224, 'Advertisement', 'Chocolate-dipped strawberries — seasonal release.', 110),
(301, 'Public Service Announcement', 'Air quality awareness campaign.', 201),
(302, 'Event', 'Bike safety workshop downtown.', 202);

INSERT INTO Billboard (billboard_id, latitude, longitude, neighborhood, sensor_id) VALUES
(1, 47.6229, -122.3223, 'Capitol Hill', 501),
(2, 47.6538, -122.3500, 'Fremont', 502),
(3, 47.6080, -122.3351, 'Downtown', 503),
(4, 47.6205, -122.3493, 'Seattle Center', 504),
(5, 47.6097, -122.3422, 'Pike Place Market', 505),
(6, 47.6613, -122.3130, 'University District', 506),
(7, 47.5513, -122.2965, 'Columbia City', 507),
(8, 47.6800, -122.3850, 'Ballard', 508),
(9, 47.5457, -122.3845, 'West Seattle', 509),
(10, 47.6145, -122.3145, 'First Hill', 510),
(11, 47.6081, -122.3352, 'Downtown', 511),
(12, 47.6082, -122.3353, 'Downtown', 512),
(13, 47.6083, -122.3354, 'Downtown', 513),
(14, 47.6084, -122.3355, 'Downtown', 514),
(15, 47.6085, -122.3356, 'Downtown', 515),
(16, 47.6600, -122.3135, 'University District', 516),
(17, 47.6610, -122.3140, 'University District', 517),
(18, 47.6230, -122.3224, 'Capitol Hill', 518),
(19, 47.6539, -122.3501, 'Fremont', 519),
(20, 47.6086, -122.3357, 'Downtown', 520),
(21, 47.6206, -122.3494, 'Seattle Center', 521),
(22, 47.6098, -122.3423, 'Pike Place Market', 522),
(23, 47.6614, -122.3131, 'University District', 523),
(24, 47.5514, -122.2966, 'Columbia City', 524),
(25, 47.6801, -122.3851, 'Ballard', 525),
(26, 47.5458, -122.3846, 'West Seattle', 526),
(27, 47.6146, -122.3146, 'First Hill', 527),
(28, 47.6086, -122.3358, 'Downtown', 528),
(29, 47.6087, -122.3359, 'Downtown', 529),
(30, 47.6088, -122.3360, 'Downtown', 530),
(31, 47.6089, -122.3361, 'Downtown', 531),
(32, 47.6090, -122.3362, 'Downtown', 532),
(33, 47.6601, -122.3136, 'University District', 533),
(34, 47.6611, -122.3141, 'University District', 534),
(35, 47.6091, -122.3363, 'Downtown', 535),
(36, 47.6092, -122.3364, 'Downtown', 536),
(37, 47.6093, -122.3365, 'Downtown', 537),
(38, 47.6094, -122.3366, 'Downtown', 538),
(39, 47.6095, -122.3367, 'Downtown', 539),
(40, 47.6096, -122.3368, 'Downtown', 540),
(41, 47.6097, -122.3369, 'Downtown', 541),
(42, 47.6098, -122.3370, 'Downtown', 542),
(43, 47.6099, -122.3371, 'Downtown', 543),
(44, 47.6100, -122.3372, 'Downtown', 544),
(45, 47.6101, -122.3373, 'Downtown', 545),
(46, 47.6102, -122.3374, 'Downtown', 546),
(47, 47.6103, -122.3375, 'Downtown', 547),
(48, 47.6104, -122.3376, 'Downtown', 548),
(49, 47.6105, -122.3377, 'Downtown', 549),
(50, 47.6106, -122.3378, 'Downtown', 550);

INSERT INTO Booking (booking_id, quote_price, start_datetime, end_datetime, content_id, billboard_id) VALUES
(1001, 500.00, '2025-06-10 07:00:00', '2025-06-10 08:00:00', 201, 1),
(1002, 520.00, '2025-06-10 08:00:00', '2025-06-10 09:00:00', 202, 2),
(1003, 540.00, '2025-06-10 09:00:00', '2025-06-10 10:00:00', 203, 3),
(1004, 560.00, '2025-06-10 10:00:00', '2025-06-10 11:00:00', 204, 3),
(1005, 580.00, '2025-06-10 11:00:00', '2025-06-10 12:00:00', 205, 5),
(1006, 600.00, '2025-06-10 12:00:00', '2025-06-10 13:00:00', 206, 6),
(1007, 620.00, '2025-06-10 13:00:00', '2025-06-10 14:00:00', 207, 7),
(1008, 640.00, '2025-06-10 14:00:00', '2025-06-10 15:00:00', 208, 8),
(1009, 660.00, '2025-06-10 15:00:00', '2025-06-10 16:00:00', 209, 9),
(1010, 680.00, '2025-06-10 16:00:00', '2025-06-10 17:00:00', 210, 10),
(1011, 975.00, '2025-07-08 00:00:00', '2025-07-15 00:00:00', 216, 3),
(1012, 550.00, '2025-06-10 10:00:00', '2025-06-10 11:00:00', 212, 3),
(1013, 610.00, '2025-06-10 13:00:00', '2025-06-10 14:00:00', 219, 6),
(1014, 690.00, '2025-06-10 17:00:00', '2025-06-10 18:00:00', 209, 22),
(2001, 700.00, '2025-06-10 17:00:00', '2025-06-10 18:00:00', 211, 11),
(2002, 720.00, '2025-06-10 18:00:00', '2025-06-10 19:00:00', 212, 12),
(2003, 500.00, '2025-06-10 07:00:00', '2025-06-10 08:00:00', 213, 13),
(2004, 520.00, '2025-06-10 08:00:00', '2025-06-10 09:00:00', 214, 14),
(2005, 540.00, '2025-06-10 09:00:00', '2025-06-10 10:00:00', 215, 15),
(3001, 560.00, '2025-06-10 10:00:00', '2025-06-10 11:00:00', 216, 16),
(3002, 580.00, '2025-06-10 11:00:00', '2025-06-10 12:00:00', 217, 17),
(6001, 600.00, '2025-06-10 12:00:00', '2025-06-10 13:00:00', 218, 18),
(6002, 620.00, '2025-06-10 13:00:00', '2025-06-10 14:00:00', 219, 19),
(6003, 640.00, '2025-06-10 14:00:00', '2025-06-10 15:00:00', 220, 20),
(6004, 660.00, '2025-06-10 15:00:00', '2025-06-10 16:00:00', 221, 21),
(6005, 680.00, '2025-06-10 16:00:00', '2025-06-10 17:00:00', 222, 22),
(6006, 700.00, '2025-06-10 17:00:00', '2025-06-10 18:00:00', 223, 23),
(6007, 720.00, '2025-06-10 18:00:00', '2025-06-10 19:00:00', 224, 24),
(6008, 500.00, '2025-06-10 07:00:00', '2025-06-10 08:00:00', 301, 25),
(6009, 520.00, '2025-06-10 08:00:00', '2025-06-10 09:00:00', 302, 26),
(6010, 540.00, '2025-06-10 09:00:00', '2025-06-10 10:00:00', 201, 27),
(7001, 560.00, '2025-06-10 10:00:00', '2025-06-10 11:00:00', 202, 28),
(7002, 580.00, '2025-06-10 11:00:00', '2025-06-10 12:00:00', 203, 29),
(7003, 600.00, '2025-06-10 12:00:00', '2025-06-10 13:00:00', 204, 30),
(7004, 620.00, '2025-06-10 13:00:00', '2025-06-10 14:00:00', 205, 31),
(7005, 640.00, '2025-06-10 14:00:00', '2025-06-10 15:00:00', 206, 32),
(7006, 660.00, '2025-06-10 15:00:00', '2025-06-10 16:00:00', 207, 33);
 
INSERT INTO Sensor_Reading (timestamp, ped_south, ped_north, bike_south, bike_north, sensor_id, booking_id) VALUES
('2025-06-08 14:00:00', 150, 165, 30, 25, 501, 1001),
('2025-06-08 14:00:00', 210, 190, 45, 55, 502, 1002),
('2025-06-08 15:00:00', 145, 170, 28, 22, 501, 1001),
('2025-06-08 15:00:00', 350, 375, 80, 75, 503, 1003),
('2025-06-08 16:00:00', 450, 475, 90, 85, 504, 1004),
('2025-06-08 16:00:00', 550, 525, 15, 20, 505, 1005),
('2025-06-09 09:00:00', 120, 130, 60, 65, 506, 1006),
('2025-06-09 09:00:00', 90, 85, 0, 0, 507, 1007),
('2025-06-09 10:00:00', 180, 200, 70, 75, 508, 1008),
('2025-06-09 10:00:00', 110, 100, 0, 0, 509, 1009),
('2025-06-11 07:00:00', 120, 135, 45, 50, 511, 2001),
('2025-06-12 08:00:00', 130, 145, 50, 55, 512, 2002),
('2025-06-13 16:00:00', 125, 140, 60, 65, 513, 2003),
('2025-06-14 17:00:00', 135, 150, 55, 60, 514, 2004),
('2025-06-15 07:00:00', 140, 160, 58, 62, 515, 2005),
('2025-07-20 09:00:00', 100, 110, 35, 40, 516, 3001),
('2025-07-22 16:00:00', 105, 115, 30, 38, 517, 3002);

INSERT INTO Sensor_Reading (timestamp, ped_south, ped_north, bike_south, bike_north, sensor_id, booking_id) VALUES
('2025-06-09 08:00:00', 140, 130, 30, 25, 516, 6001),
('2025-06-09 09:00:00', 150, 145, 35, 40, 517, 6001),
('2025-06-09 10:00:00', 160, 155, 38, 42, 523, 6002),
('2025-06-09 11:00:00', 170, 165, 41, 43, 533, 6002),
('2025-06-09 12:00:00', 180, 175, 45, 47, 534, 6002),
('2025-07-20 08:00:00', 110, 115, 20, 22, 516, 6003),
('2025-07-20 09:00:00', 115, 120, 25, 27, 517, 6003),
('2025-07-20 10:00:00', 120, 125, 28, 30, 523, 6003),
('2025-07-20 11:00:00', 125, 130, 32, 34, 533, 6003),
('2025-07-20 12:00:00', 130, 135, 35, 38, 534, 6003),
('2025-07-22 08:00:00', 145, 140, 50, 55, 516, 6004),
('2025-07-22 09:00:00', 150, 148, 52, 54, 517, 6004),
('2025-07-22 10:00:00', 155, 150, 55, 56, 523, 6004),
('2025-07-22 11:00:00', 160, 158, 57, 59, 533, 6004),
('2025-07-22 12:00:00', 165, 160, 60, 62, 534, 6004);

SELECT * FROM Organization;
SELECT * FROM Content;
SELECT * FROM Billboard;
SELECT * FROM Sensor_Reading;
SELECT * FROM Booking;
