CREATE TABLE `stations` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE `types` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL,
`max_seats` VARCHAR(20) NOT NULL,
`fare_rate` INT NOT NULL
) ENGINE=InnoDB;
CREATE TABLE `trains` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`type` INT NOT NULL,
`source` INT NOT NULL,
`destination` INT NOT NULL,
`departure` TIME NOT NULL,
`arrival` TIME NOT NULL,
`distance` INT NOT NULL,
FOREIGN KEY (`type`) REFERENCES `types`(`id`) ON DELETE CASCADE,
FOREIGN KEY (`source`) REFERENCES `stations`(`id`) ON DELETE CASCADE,
FOREIGN KEY (`destination`) REFERENCES `stations`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE `users` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE `tickets` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`train` INT NOT NULL,
`user` INT NOT NULL,
`seat_number` INT NOT NULL,
FOREIGN KEY (`train`) REFERENCES `trains`(`id`) ON DELETE CASCADE,
FOREIGN KEY (`user`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

--1 
SELECT users.id, `name`, seat_number FROM tickets INNER JOIN users ON users.id = tickets.user 
WHERE tickets.train = 11
ORDER BY seat_number ASC;

--2
SELECT users.id, `name`, Count(*) AS train_count, Sum(trains.distance) AS total_distance
FROM tickets INNER JOIN users ON tickets.user = users.id INNER JOIN trains ON trains.id = tickets.train
GROUP BY users.id ORDER BY total_distance DESC LIMIT 6;

--3
SELECT trains.id, types.name, stations.name AS src_stn, stations.name AS dst_stn, Timediff(arrival, departure) AS travel_time
FROM trains INNER JOIN stations ON trains.source = stations.id AND trains.destination = stations.id INNER JOIN types ON types.id = trains.type
ORDER BY travel_time DESC LIMIT 6; 

--4
SELECT trains.type, trains.source AS src_stn, trains.destination AS dst_stn, trains.arrival, ((trains.distance / 1000) * types.fare_rate) AS fare
FROM trains INNER JOIN types ON trains.type = types.id;