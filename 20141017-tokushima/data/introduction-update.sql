USE tokushima;
ALTER TABLE introduction
  ADD COLUMN _photo VARCHAR(255);

UPDATE introduction
  SET _photo = '/images/crumbjp.jpg'
  WHERE name = '窪田 博昭';

SELECT * FROM introduction;
SELECT * FROM activities;
