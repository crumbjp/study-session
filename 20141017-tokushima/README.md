
# 第３回とくしまOSS勉強会

## Clone this project
```sh
export BASE_DIR="$HOME/tokushima-oss"
mkdir -p $BASE_DIR
cd $BASE_DIR
git clone https://github.com/crumbjp/study-session.git
cd study-session/20141017-tokushima/
```

## Setup mongo
```sh
brew install wget
mkdir -p var
wget https://fastdl.mongodb.org/osx/mongodb-osx-x86_64-2.6.5.tgz -O mongodb-osx-x86_64-2.6.5.tgz
tar xzvf mongodb-osx-x86_64-2.6.5.tgz
mkdir -p mongo
mv mongodb-osx-x86_64-2.6.5/bin mongo/bin
mkdir mongo/data1
mkdir mongo/data2
mkdir mongo/data3
mongo/bin/mongod --dbpath ./mongo/data1
```

## Setup amysql
```
brew install mysql
mysqld
```

## Setup express and start
```
brew install node
pushd project
npm install

./bin/www
```


```
mkdir project
npm init -f
npm install express --save-dev
npm install mongolian --save-dev
npm install mysql --save-dev
npm install express-generator --save-dev
export PATH=./node_modules/.bin:$PATH
express -e -f .
npm install
./bin/www

```

```
#!/usr/bin/env bash

/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/conf/mongod.conf

```


use tokushima
db.dropDatabase();
db.introduction.save({
  '氏名': '窪田 博昭',
  '肩書': 'MongoDBJP代表',
  'ハンドルネーム': 'crumbjp',
  '活動': {
    'LinuxとApacheの憂鬱': 'http://d.hatena.ne.jp/hiroppon/',
    'slideshare': 'http://www.slideshare.net/crumbjp/',
    'データベースエンジニア養成読本(寄稿)': 'http://gihyo.jp/book/2013/978-4-7741-5806-8/',
    'MongoDBJP': 'http://mongodb.jp/mongo/main/'
  }
});


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



db.introduction.update({'氏名': '窪田 博昭'},{$set: {'_photo': '/images/crumbjp.jpg'}});

ALTER TABLE introduction
  ADD COLUMN _photo VARCHAR(255);

UPDATE introduction SET _photo = '/images/crumbjp.jpg' WHERE name = '窪田 博昭';

```
db.slides.ensureIndex({page:1}, {uniq: 1});

{ "_id" : { "$oid" : "543bf23cb26f6b0f7329c21c" }, "page" : 1, "title" : "LAMP（ランプ）構成", "sections" : [ { "list" : [ "Linux", "Apache", "MySQL", "Perl/PHP/Python" ] }, { "block" : "2000年代の標準的なWebサイトの構成。まだ言語やミドルウェアの選択が重要な時代。様々なフレームワークが登場し淘汰された。" }, { "block" : "次第にMVCアーキテクチャがWebの標準となっていく。" } ] }
{ "_id" : { "$oid" : "543bede8b26f6b0f7329c217" }, "page" : 2, "title" : "フルスタック・フレームワーク", "sections" : [ { "list" : [ "Ruby on Rails", "MySQL" ] }, { "block" : "2010年前後から台頭した。MVCアーキテクチャの一つの完成系。" }, { "block" : "OS/ミドルウェア/DBの違いはフレームワークの機能として取り込まれ、アプリケーション開発において意識する必要が（ほとんど）無い。" }, { "block" : "最大の特徴は" }, { "strong" : "設定より規約" }, { "block" : "アプリケー ションの作りが均一化された事でライブラリー化が促進され、ますます発展した。" }, { "strong" : "しかし明確な弱点がある" }, { "list" : [ "Rubyの言語としての速度不足", "MySQLを想定したO/R Mapper(AR)" ] }, { "strong" : "Python（pypy）で実装したRubyを使うと数倍速くなる" }, { "block" : "などRubyの速度不足は深刻でPythonやnodeJSなどの台頭を許す要因になっている。" }, { "block" : "またフレームワークとしてMySQLとの結合度が高く、MySQLの限界に引きずられる。"}, { list: ["負荷分散", "大規模テーブルのALTER"] } ] }
{ "_id" : { "$oid" : "543bf6b7b26f6b0f7329c21d" }, "page" : 3, "title" : "MEAN（ミーン）/ MEN（メン）スタック", "sections" : [ { "list" : [ "MongoDB", "Express", "AngularJS", "NodeJS" ] }, { "block" : "最近流行始めた有望な構成。４つを組み合わせる事でRailsと同じ範囲をカバーできる。" }, { "block" : "完成度はまだ低いものの" }, { "strong" : "Railsの弱点" }, { "block" : "を解決している。" }, { "block" : "スキーマレスなMongoDBはMySQLよりも格段に変更に強く、負荷分散も容易。" }, { "block" : "性能に関しては申し分無く、rubyと比較して10倍以上の差になる事もある。" }, { "block" : "反面、まだ完成度が低く、圧倒的性能差があるにも関わらず開発コストを考慮した時Railsの方が良い場合もある。" } ] }
