use tokushima
db.introduction.update(
  {
    '氏名': '窪田 博昭'
  },
  {
    $set: {
      '_photo': '/images/crumbjp.jpg'
    }
  });
db.introduction.findOne();
