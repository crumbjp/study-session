 DROP DATABASE IF EXISTS sample;
 CREATE DATABASE sample;
 USE sample;

 CREATE TABLE people (
   _id int(11) UNSIGNED NOT NULL,
   first VARCHAR(25),
   family VARCHAR(25),
   sex VARCHAR(10),
   PRIMARY KEY (_id)
 )ENGINE=InnoDB;

 CREATE TABLE hobies (
   _pid int(11) UNSIGNED NOT NULL,
   name VARCHAR(20)
 )ENGINE=InnoDB;


