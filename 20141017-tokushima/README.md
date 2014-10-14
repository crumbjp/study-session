
# 第３回とくしまOSS勉強会

## Clone this project
```sh
export DIR="$HOME/tokushima-oss"
mkdir -p $DIR
cd $DIR
git clone https://github.com/crumbjp/study-session.git
cd study-session/20141017-tokushima/
```

## Start mongo
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mkdir -p $BASE_DIR/mongo/data1
mongod --dbpath $BASE_DIR/mongo/data1

```

## Start MySQL
```sh
brew install mysql
mysqld
```

# Import data
## Import to mongo
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mongo --quiet <$BASE_DIR/data/introduction.js
```

```js
switched to db tokushima
{ "dropped" : "tokushima", "ok" : 1 }
WriteResult({ "nInserted" : 1 })
{
  "_id" : ObjectId("543d3c66428c3cdd6175fd55"),
  "氏名" : "窪田 博昭",
  "肩書" : "MongoDBJP代表",
  "ハンドルネーム" : "crumbjp",
  "活動" : {
    "LinuxとApacheの憂鬱" : "http://d.hatena.ne.jp/hiroppon/",
    "slideshare" : "http://www.slideshare.net/crumbjp/",
    "データベースエンジニア養成読本(寄稿)" : "http://gihyo.jp/book/2013/978-4-7741-5806-8/",
    "MongoDBJP" : "http://mongodb.jp/mongo/main/"
  }
}
```
https://github.com/crumbjp/study-session/blob/master/20141017-tokushima/data/introduction.js

## Import to MySQL
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mysql -u root <$BASE_DIR/data/introduction.sql
```

```
_id     name    title   handle
1       窪田 博昭       MongoDBJP代表   crumbjp

_id     _introduction_id        name    url
1       1       LinuxとApacheの憂鬱     http://d.hatena.ne.jp/hiroppon/
2       1       slideshare      http://www.slideshare.net/crumbjp/
3       1       データベースエンジニア養成読本(寄稿)    http://gihyo.jp/book/2013/978-4-7741-5806-8/
4       1       MongoDBJP       http://mongodb.jp/mongo/main/
```
https://github.com/crumbjp/study-session/blob/master/20141017-tokushima/data/introduction.sql

## Mongo ReplicaSet
```sh
pkill mongod
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mongod --dbpath $BASE_DIR/mongo/data1 --port 27017 --replSet 'tokushima-RS'
```

```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mkdir -p $BASE_DIR/mongo/data2
mongod --dbpath $BASE_DIR/mongo/data2 --port 27018 --replSet 'tokushima-RS'
```

```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mkdir -p $BASE_DIR/mongo/data3
mongod --dbpath $BASE_DIR/mongo/data3 --port 27019 --replSet 'tokushima-RS'
```

```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mongo --quiet <$BASE_DIR/data/replset.js
```
https://github.com/crumbjp/study-session/blob/master/20141017-tokushima/data/replset.js

## Express
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
cd project
brew install node
npm install
./bin/www
```

## Update to mongo
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mongo --quiet <$BASE_DIR/data/introduction-update.js
```

```
switched to db tokushima
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
{
        "_id" : ObjectId("543d3c66428c3cdd6175fd55"),
        "氏名" : "窪田 博昭",
        "肩書" : "MongoDBJP代表",
        "ハンドルネーム" : "crumbjp",
        "活動" : {
                "LinuxとApacheの憂鬱" : "http://d.hatena.ne.jp/hiroppon/",
                "slideshare" : "http://www.slideshare.net/crumbjp/",
                "データベースエンジニア養成読本(寄稿)" : "http://gihyo.jp/book/2013/978-4-7741-5806-8/",
                "MongoDBJP" : "http://mongodb.jp/mongo/main/"
        },
        "_photo" : "/images/crumbjp.jpg"
}
```
https://github.com/crumbjp/study-session/blob/master/20141017-tokushima/data/introduction-update.js

## Update to MySQL
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mysql -u root <$BASE_DIR/data/introduction-update.sql
```

```
_id     name    title   handle  _photo
1       窪田 博昭       MongoDBJP代表   crumbjp /images/crumbjp.jpg

_id     _introduction_id        name    url
1       1       LinuxとApacheの憂鬱     http://d.hatena.ne.jp/hiroppon/
2       1       slideshare      http://www.slideshare.net/crumbjp/
3       1       データベースエンジニア養成読本(寄稿)    http://gihyo.jp/book/2013/978-4-7741-5806-8/
4       1       MongoDBJP       http://mongodb.jp/mongo/main/
```

https://github.com/crumbjp/study-session/blob/master/20141017-tokushima/data/introduction-update.sql

## Import slide
```sh
export BASE_DIR="$HOME/tokushima-oss/study-session/20141017-tokushima/"
mongoimport -d tokushima -c slides $BASE_DIR/data/slides.export.js
```
https://github.com/crumbjp/study-session/blob/master/20141017-tokushima/data/slides.export.js

## Mongo
```js
use tokushima
db.introduction.update({'氏名': '窪田 博昭'}, {$set: {'活動.勉強会': 'とくしまOSS勉強会'}});
db.introduction.findOne({})

db.slides.findOne({page:1})
db.slides.update({page:1}, {$push: {sections: {strong: 'PHP懐かしい！！'}}});
db.slides.findOne({page:1})

```
