DROP DATABASE tokushima;
CREATE DATABASE tokushima;
USE tokushima;

CREATE TABLE introduction (
  _id INT PRIMARY KEY,
  name VARCHAR(255),
  title VARCHAR(255),
  handle VARCHAR(255)
);

CREATE TABLE activities (
  _id INT PRIMARY KEY AUTO_INCREMENT,
  _introduction_id INT,
  name VARCHAR(255),
  url VARCHAR(255),
  FOREIGN KEY(_introduction_id) REFERENCES introduction(_id)
);
INSERT INTO introduction (_id, name, title, handle)
  VALUES (1, '窪田 博昭', 'MongoDBJP代表', 'crumbjp');

INSERT INTO activities (_introduction_id, name, url)
  VALUES (1, 'LinuxとApacheの憂鬱', 'http://d.hatena.ne.jp/hiroppon/'),
         (1, 'slideshare', 'http://www.slideshare.net/crumbjp/'),
         (1, 'データベースエンジニア養成読本(寄稿)', 'http://gihyo.jp/book/2013/978-4-7741-5806-8/'),
         (1, 'MongoDBJP', 'http://mongodb.jp/mongo/main/');

SELECT * FROM introduction;
SELECT * FROM activities;
