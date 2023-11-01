CREATE TABLE student(
    id int primary key auto_increment,
    `name` varchar(45),
    s_id varchar(12),
    admission_year int,
    major varchar(45),
    tel varchar(15),
    `address` varchar(100),
    total_credits int default 0,
    average_gpa decimal(3, 2) default 0.0,
    enrolled boolean true
)