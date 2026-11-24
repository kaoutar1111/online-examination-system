-- user TABLE
CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'teacher', 'student') DEFAULT 'student',
  recovery_code VARCHAR(10), 
  creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SAMPLE USER
INSERT INTO user (name, email, password, role)
VALUES ('Kaoutar Ait Benali', 'kaoutaraitbenali@gmail.com', '123', 'admin');

-- EXAMS TABLE
CREATE TABLE exams (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  subject VARCHAR(100),
  created_by INT,
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  published TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES user(id)
);

INSERT INTO exams (title, subject, created_by)
VALUES ('Final Java Exam', 'Java Programming', 1);

-- QUESTIONS TABLE
CREATE TABLE questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  test_id INT NOT NULL,
  question_text TEXT NOT NULL,
  correct_answer TEXT,
  points DECIMAL(5,2),
  FOREIGN KEY (test_id) REFERENCES exams(id)
);

-- ANSWERS TABLE
CREATE TABLE answers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  question_id INT NOT NULL,
  given_answer TEXT,
  answered_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES user(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- CHEATING ATTEMPTS TABLE
CREATE TABLE cheating_attempts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  reason VARCHAR(255),
  attempts INT DEFAULT 1,
  registrated_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES user(id)
);

-- RESULTS TABLE
CREATE TABLE results (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  test_id INT NOT NULL,
  mark DECIMAL(5,2),
  reviewed_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES user(id),
  FOREIGN KEY (test_id) REFERENCES exams(id)
);

-- MANUAL GRADING TABLE
CREATE TABLE manual_grading (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  question_id INT NOT NULL,
  answer TEXT,
  mark DECIMAL(5,2),
  reviewed_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES user(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);
