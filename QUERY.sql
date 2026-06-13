
CREATE DATABASE football_ticket_booking_db;



-- USERS TABLE
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    phone_number VARCHAR(20)
);



CREATE DATABASE IF NOT EXISTS football_ticket_booking_db;

-- USERS TABLE
CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('Ticket Manager','Football Fan')),
    phone_number VARCHAR(20)
);


-- MATCHES TABLE
CREATE TABLE IF NOT EXISTS Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(50) NOT NULL,
    base_ticket_price DECIMAL(10,2) NOT NULL CHECK (base_ticket_price >= 0),
    match_status VARCHAR(20) NOT NULL CHECK (match_status IN ('Available','Selling Fast','Sold Out','Postponed'))
);


-- BOOKINGS TABLE
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(20),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending','Confirmed','Cancelled','Refunded')),
    total_cost DECIMAL(10,2) CHECK (total_cost >= 0),

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);


-- SAMPLE DATA (matches assignment description/sample)
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);


-- =========================
-- Part 2: Required Queries
-- =========================

-- Query 1: Champions League matches with status 'Available'
SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';

-- Query 2: Users whose name starts with 'Tanvir' or contains 'Haque' (case-insensitive)
SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';

-- Query 3: Bookings where payment_status IS NULL, replacing with 'Action Required'
SELECT booking_id, user_id, match_id,
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;

-- Query 4: Booking details with user's full name and match fixture (INNER JOIN)
SELECT b.booking_id, u.full_name, m.fixture, b.total_cost
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Matches m ON b.match_id = m.match_id
ORDER BY b.booking_id;

-- Query 5: All users and their booking IDs (include users with no bookings)
SELECT u.user_id, u.full_name, b.booking_id
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
ORDER BY u.user_id, b.booking_id;

-- Query 6: Bookings with total_cost strictly higher than the average total_cost
SELECT booking_id, match_id, total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);

-- Query 7: Top 2 most expensive matches, skipping the absolute most expensive
SELECT match_id, fixture, base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
OFFSET 1 LIMIT 2;

