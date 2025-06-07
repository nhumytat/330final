USE BGT_Billboards;

DROP TABLE IF EXISTS Sensor_Reading;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Billboard;
DROP TABLE IF EXISTS Content;
DROP TABLE IF EXISTS Organization;


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
