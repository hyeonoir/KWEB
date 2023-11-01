CREATE TABLE users(
    id int primary key auto_increment,
    u_id varchar(20),
    u_pw varchar(45),
    photo text,
    p_mesg text,
    is_left boolean default 0,
    creation_date date
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE channels (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100) NOT NULL,
    creator_user_id INT,
    channel_link VARCHAR(255),
    max_capacity INT,
    is_deleted boolean DEFAULT 0,
    creation_date DATE,
    foreign key (creator_user_id) references users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE chats (
    id INT PRIMARY KEY auto_increment,
    msg TEXT NOT NULL,
    author INT,
    channel_id INT,
    creation_date DATE,
    foreign key (author) references users(id),
    foreign key (channel_id) references channels(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE follows (
    id INT PRIMARY KEY auto_increment,
    follower INT,
    followee INT,
    follow_date DATE,
    foreign key (follower) references users(id),
    foreign key (followee) references users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE blocks (
    id INT PRIMARY KEY auto_increment,
    blocker INT,
    blocked INT,
    block_date DATE,
    foreign key (blocker) references users(id),
    foreign key (blocked) references users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;