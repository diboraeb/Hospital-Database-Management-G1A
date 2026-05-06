CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

CREATE TABLE Department(
dept_id INT AUTO_INCREMENT PRIMARY KEY, 
dept_name VARCHAR(100) UNIQUE NOT NULL, 
location VARCHAR(100), 
phone VARCHAR(20) 
);

CREATE TABLE Doctor(
doctor_id INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(50) NOT NULL, 
last_name VARCHAR(50) NOT NULL, 
specialization VARCHAR(100) NOT NULL, 
phone VARCHAR(20) UNIQUE, 
email VARCHAR(100) UNIQUE,  
dept_id INT ,
hire_date DATE, 
FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Patient(
patient_id INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(50) NOT NULL, 
last_name VARCHAR(50) NOT NULL, 
gender ENUM('M','F'), 
dob DATE, 
phone VARCHAR(20) UNIQUE, 
email VARCHAR(100) UNIQUE,  
address TEXT,
blood_type VARCHAR(3)
);

CREATE TABLE Medical_Case(
case_id INT AUTO_INCREMENT PRIMARY KEY, 
patient_id INT NOT NULL, 
doctor_id INT NOT NULL, 
diagnosis TEXT, 
treatment_plan TEXT, 
start_date DATE, 
end_date DATE, 
status VARCHAR(50), 
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id), 
FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id)

);

CREATE TABLE Appointment(
appointment_id INT AUTO_INCREMENT PRIMARY KEY,  
patient_id INT NOT NULL, 
doctor_id INT NOT NULL, 
appt_date DATE, 
appt_time TIME, 
status VARCHAR(20), 
reason TEXT, 
case_id INT, 
FOREIGN KEY(case_id) REFERENCES Medical_Case(case_id), 
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id), 
FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Room(
room_id INT AUTO_INCREMENT PRIMARY KEY, 
room_no VARCHAR(10) UNIQUE, 
room_type VARCHAR(50), 
status VARCHAR(20)
);

CREATE TABLE Admission(
admission_id INT AUTO_INCREMENT PRIMARY KEY, 
patient_id INT NOT NULL, 
doctor_id INT NOT NULL, 
room_id INT NOT NULL, 
admission_date DATE,
discharge_date DATE, 
status VARCHAR(20), 
case_id INT NOT NULL, 
FOREIGN KEY(case_id) REFERENCES Medical_Case(case_id), 
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id), 
FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id), 
FOREIGN KEY(room_id) REFERENCES Room(room_id)
);

