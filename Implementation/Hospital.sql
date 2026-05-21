CREATE DATABASE hospital_db;
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
Specialization VARCHAR(100) NOT NULL,
phone VARCHAR(20) UNIQUE,
email VARCHAR(100) UNIQUE,
dept_id INT,
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
blood_type VARCHAR(3),
emergency_contact VARCHAR(100),
Emergency_phone VARCHAR(20)
);

CREATE TABLE Ward(
ward_id INT AUTO_INCREMENT PRIMARY KEY,
ward_name VARCHAR(50) UNIQUE NOT NULL,
ward_type VARCHAR(50),
floor INT,
capacity INT
);

CREATE TABLE Room(
room_id INT AUTO_INCREMENT PRIMARY KEY,
room_no VARCHAR(10) UNIQUE,
ward_id INT,
room_type VARCHAR(50),
bed_count INT DEFAULT 1,
status VARCHAR(20),
FOREIGN KEY(ward_id) REFERENCES Ward(ward_id),
UNIQUE(room_no, ward_id)
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
FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id),
UNIQUE(patient_id, doctor_id, start_date)
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
FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id),
UNIQUE(patient_id, doctor_id, appt_date, appt_time)
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
FOREIGN KEY(room_id) REFERENCES Room(room_id),
UNIQUE(patient_id, room_id, admission_date)
);

CREATE TABLE Medical_Record(
record_id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
admission_id INT,
diagnosis_date DATE,
symptoms TEXT,
diagnosis TEXT,
note TEXT,
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id),
FOREIGN KEY(admission_id) REFERENCES Admission(admission_id),
UNIQUE (patient_id,doctor_id, diagnosis_date)
);

CREATE TABLE Medication(
medication_id INT AUTO_INCREMENT PRIMARY KEY, 
med_name VARCHAR(100) NOT NULL,
dosage_form VARCHAR(50),
unit VARCHAR(20),
description TEXT,
stock_qty INT DEFAULT 0,
UNIQUE(med_name, dosage_form, unit)
);

CREATE TABLE Prescription(
prescription_id INT AUTO_INCREMENT PRIMARY KEY,
record_id INT NOT NULL,
medication_id INT NOT NULL,
frequency VARCHAR(50),
duration VARCHAR(50),
quantity INT,
FOREIGN KEY(record_id) REFERENCES Medical_Record(record_id),
FOREIGN KEY(medication_id) REFERENCES Medication(medication_id),
UNIQUE(record_id, medication_id)
);

CREATE TABLE Lab_Test(
test_id INT AUTO_INCREMENT PRIMARY KEY,
test_name VARCHAR(100) UNIQUE NOT NULL,
description TEXT,
cost DECIMAL(10,2)
);

CREATE TABLE Lab_Order(
order_id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
test_id INT NOT NULL,
order_date DATE,
status VARCHAR(20),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN  KEY(doctor_id) REFERENCES Doctor(doctor_id),
FOREIGN KEY(test_id) REFERENCES Lab_Test(test_id),
UNIQUE(patient_id, doctor_id, test_id, order_date)
);

CREATE TABLE Lab_Result(
result_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT UNIQUE NOT NULL,
result_value VARCHAR(100),
result_date DATE,
is_normal BOOLEAN,
notes TEXT,
FOREIGN KEY(order_id) REFERENCES Lab_Order(order_id)
);

CREATE TABLE payment(
payment_id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT NOT NULL,
admission_id INT,
amount DECIMAL(10,2),
payment_date DATE,
payment_method VARCHAR(50),
status VARCHAR(20),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY(admission_id) REFERENCES Admission(admission_id),
UNIQUE(patient_id, admission_id, payment_date, amount)
);

CREATE TABLE Nurse(
nurse_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
phone VARCHAR(20),
email VARCHAR(100),
dept_id INT,
shift VARCHAR(20),
FOREIGN KEY(dept_id) REFERENCES Department(dept_id),
UNIQUE(phone),
UNIQUE(email)
);
