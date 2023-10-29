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
-- SELECT U.username AS user, F.friendID, UF.username AS friend
-- FROM Friends F
-- INNER JOIN Users U ON F.userID = U.userID
-- INNER JOIN Users UF ON F.friendID = UF.userID
-- WHERE U.userID = 1;
