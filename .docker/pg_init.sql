create database moodle;

create user moodleuser with encrypted password 'moodlepassword';

grant all privileges on database moodle to moodleuser;
