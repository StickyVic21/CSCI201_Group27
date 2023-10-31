CREATE TABLE Users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    score1 INT DEFAULT 0,
    score2 INT DEFAULT 0,
    score3 INT DEFAULT 0
);

CREATE TABLE Friends (
    userID INT,
    friendID INT,
    PRIMARY KEY (userID, friendID),
    FOREIGN KEY (userID) REFERENCES Users(userID),
    FOREIGN KEY (friendID) REFERENCES Users(userID)
);

CREATE TABLE FriendRequests (
    requestID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT,
    friendID INT,
    FOREIGN KEY (userID) REFERENCES Users(userID),
    FOREIGN KEY (friendID) REFERENCES Users(userID)
);

-- creating user:
-- INSERT INTO Users (username, password, score1, score2, score3) 
-- VALUES ('admin', 'csci201', 0, 0, 0);

-- adding a friend for userID:
-- INSERT INTO Friends (userID, friendID) VALUES (1, 2);

-- updating a user's score 
-- UPDATE Users
-- SET score1 = 0
-- WHERE username = 'admin';

-- retrieving a user's friends list 
-- SELECT f.userID, u.username AS friendUsername
-- FROM Friends AS f
-- INNER JOIN Users AS u ON f.friendID = u.userID
-- WHERE f.userID = (SELECT userID FROM Users WHERE username = 'user');


-- checking if a username is a friend of the user: (for requesting a friend) 
-- SELECT f.friendID, u.username AS friendUsername
-- FROM Friends AS f
-- INNER JOIN Users AS u ON f.friendID = u.userID
-- WHERE f.userID = (SELECT userID FROM Users WHERE username = 'username')
-- AND u.username = ‘requestedUsername’ ;


