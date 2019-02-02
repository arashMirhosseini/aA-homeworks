DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_tags;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;  -- turn on the foreign key constraints to ensure data integrity

-- users

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

INSERT INTO
  users(fname, lname)
VALUES
  ("Ned", "Ruggeri"), ("Kush", "Patel"), ("Earl", "Cat");

--questions
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, author_id)
SELECT
  "Ned Question", "NED NED NED", users.id
FROM
  users
WHERE
  users.fname = 'Ned' AND users.lname = 'Ruggeri';

INSERT INTO
  questions(title, body, author_id)
SELECT
  "Kush Question", "KUSH KUSH KUSH", users.id
FROM
  users
WHERE
  users.fname = 'Kush' AND users.lname = 'Patel';

INSERT INTO
  questions(title, body, author_id)
SELECT
  "Earl Question", "MEOW MEOW MEOW", users.id
FROM
  users
WHERE
  users.fname = 'Earl' AND users.lname = 'Cat';
  

-- question_follows
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  question_follows(user_id, question_id)
VALUES
  ((SELECT users.id FROM users WHERE fname = 'Ned' AND lname = 'Ruggeri'),
   (SELECT questions.id FROM questions WHERE title = "Earl Question")),
   ((SELECT users.id FROM users WHERE fname = 'Kush' AND lname = 'Patel'),
   (SELECT questions.id FROM questions WHERE title = "Earl Question"));

-- replies
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

INSERT INTO 
  replies(question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT questions.id FROM questions WHERE title = "Earl Question"),
  (SELECT replies.id FROM replies WHERE body = "Did you say NOW NOW NOW?" ),
  (SELECT id FROM users WHERE fname = 'Kush' AND lname = 'Patel'),
  "I think he said MEOW MEOW MEOW.");

-- question_likes
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO 
  question_likes(user_id, question_id)
VALUES
  (
    (SELECT id FROM users WHERE fname = "Kush" AND lname = "Patel"),
    (SELECT id FROM questions WHERE title = "Earl Question")
  );
INSERT INTO question_likes
  (user_id, question_id)
VALUES
  (1, 1);
INSERT INTO question_likes
  (user_id, question_id)
VALUES 
  (1, 2);

-- tags
CREATE TABLE tags (
  id INTEGER PRIMARY KEY,
  name TEXT
);

INSERT INTO tags(name)
VALUES
  ("Ruby");
INSERT INTO tags(name)
VALUES
  ("Javascript");
INSERT INTO tags(name)
VALUES
  ("CSS");

--question_tags
CREATE TABLE question_tags (
  id INTEGER PRIMARY KEY,
  tag_id INTEGER NOT NULL,

  FOREIGN KEY (tag_id) REFERENCES tags(id)
);

INSERT INTO question_tags(question_id, tag_id) VALUES (1, 1);
INSERT INTO question_tags(question_id, tag_id) VALUES (1, 2);
INSERT INTO question_tags(question_id, tag_id) VALUES (1, 3);
INSERT INTO question_tags(question_id, tag_id) VALUES (1, 4);
INSERT INTO question_tags(question_id, tag_id) VALUES (2, 3);
INSERT INTO question_tags(question_id, tag_id) VALUES (2, 4);





