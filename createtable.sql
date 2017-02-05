CREATE TABLE IF NOT EXISTS faculty_info (
  faculty_id INT NOT NULL AUTO_INCREMENT,
  faculty_name VARCHAR(256),
  email VARCHAR(256),
  phone VARCHAR(256), 
  responsibility VARCHAR(256),
  website VARCHAR(256),
  designation VARCHAR(256),
  research_area VARCHAR(2000),
  PRIMARY KEY (faculty_id)
);

CREATE TABLE IF NOT EXISTS publications (
  pub_id INT NOT NULL AUTO_INCREMENT,
  faculty_name VARCHAR(256),
  pub_year INT,
  pub_title VARCHAR(2000),
  PRIMARY KEY (pub_id)
);

CREATE TABLE IF NOT EXISTS projects (
  project_id INT NOT NULL AUTO_INCREMENT,
  faculty_name VARCHAR(256),
  project_title VARCHAR(2000),
  PRIMARY KEY (project_id)
);

CREATE TABLE IF NOT EXISTS students (
  student_id INT NOT NULL AUTO_INCREMENT,
  faculty_name VARCHAR(256),
  student_name VARCHAR(2000),
  student_type VARCHAR(256),
  std_research_area VARCHAR(2000),
  PRIMARY KEY (student_id)
);

CREATE TABLE IF NOT EXISTS awards (
  award_id INT NOT NULL AUTO_INCREMENT,
  faculty_name VARCHAR(256),
  award VARCHAR(2000),
  PRIMARY KEY (award_id)
);
