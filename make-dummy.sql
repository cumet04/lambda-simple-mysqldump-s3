-- refs https://qiita.com/tayasu/items/c5ddfc481d6b7cd8866d

create database db;
use db;

CREATE TABLE item (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(10),
  description VARCHAR(30),
  price INT UNSIGNED,
  created_at DATETIME
);

INSERT INTO item () VALUES ();
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;

UPDATE item SET
  name = CONCAT('商品', id),
  description = SUBSTRING(MD5(RAND()), 1, 30),
  price = CEIL(RAND() * 10000),
  created_at = ADDTIME(CONCAT_WS(' ','2014-01-01' + INTERVAL RAND() * 180 DAY, '00:00:00'), SEC_TO_TIME(FLOOR(0 + (RAND() * 86401))));
