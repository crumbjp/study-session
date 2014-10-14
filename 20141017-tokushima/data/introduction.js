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
db.introduction.findOne();
