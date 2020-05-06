create database lifeline;
USE lifeline;

CREATE TABLE member (
    phone VARCHAR(15) PRIMARY KEY,
    member_name VARCHAR(20) NOT NULL,
    acc_pass VARCHAR(255) NOT NULL,
    profile_picture VARCHAR(110) NOT NULL DEFAULT 'http://praveenv.org/lifeline/person/profpics/defaultpic.png',
    latitude DOUBLE NOT NULL DEFAULT 41.40338,
    longitude DOUBLE NOT NULL DEFAULT 2.17403,
    timing VARCHAR(30) NOT NULL DEFAULT '2017-09-22 16:00:00 +0000'
);

CREATE TABLE family (
    family_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    family_name VARCHAR(20) NOT NULL,
    owner_phone VARCHAR(15) NOT NULL,
    profile_picture VARCHAR(110) NOT NULL DEFAULT 'http://praveenv.org/lifeline/group/profpics/defaultpic.png',
    FOREIGN KEY (owner_phone)
        REFERENCES member (phone)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE family_member (
    family_id INT NOT NULL,
    member_phone VARCHAR(15) NOT NULL,
    role VARCHAR(3),
    FOREIGN KEY (family_id)
        REFERENCES family (family_id)
        ON DELETE CASCADE,
    FOREIGN KEY (member_phone)
        REFERENCES member (phone)
        ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (family_id , member_phone)
);

CREATE TABLE map_zone (
    family_id INT NOT NULL,
    member_phone VARCHAR(15) NOT NULL,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    timing_start VARCHAR(30) NOT NULL,
    timing_end VARCHAR(30) NOT NULL,
    radius DOUBLE NOT NULL,
    safe BOOLEAN NOT NULL,
    zone_name VARCHAR(30) NOT NULL,
    FOREIGN KEY (family_id)
        REFERENCES family_member (family_id)
        ON DELETE CASCADE,
    FOREIGN KEY (member_phone)
        REFERENCES family_member (member_phone)
        ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (family_id , member_phone , latitude , longitude)
);