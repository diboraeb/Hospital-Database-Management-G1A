INSERT INTO Department(dept_name, location, phone) VALUES
('Cardiology', 'Building A', '0911000001'),
('Neurology', 'Building B', '0911000002'),
('Pediatrics', 'Building C', '0911000003');

INSERT INTO Doctor(first_name, last_name, Specialization, phone, email, dept_id, hire_date) VALUES
('Abel', 'Mulatu', 'Cardiologist', '0922000001', 'abel@gmail.com', 1, '2020-01-15'),
('Tsgereda', 'Getahun', 'Neurologist', '0922000002', 'tgereda@gmail.com', 2, '2021-03-10');

INSERT INTO Patient(first_name, last_name, gender, dob, phone, email, address, blood_type, emergency_contact, Emergency_phone) VALUES
('Melaku', 'Bizuneh', 'M', '1995-05-12', '0933000001', 'melaku@gmail.com', 'Addis Ababa', 'A+', 'Daniel Dinku', '0944000001'),
('Elsa', 'Abreham', 'F', '2000-08-20', '0933000002', 'Elsa@gmail.com', 'Adama', 'O-', 'Fitusm Yawkal', '0944000002');

INSERT INTO Ward(ward_name, ward_type, floor, capacity) VALUES
('Ward A', 'General', 1, 20),
('Ward B', 'ICU', 2, 10);


INSERT INTO Room(room_no, ward_id, room_type, bed_count, status) VALUES
('101', 1, 'Standard', 2, 'Available'),
('201', 2, 'ICU', 1, 'Occupied');


INSERT INTO Medical_Case(patient_id, doctor_id, diagnosis, treatment_plan, start_date, end_date, status) VALUES
(1, 1, 'Heart Disease', 'Medication and monitoring', '2026-05-01', NULL, 'Active'),
(2, 2, 'Migraine', 'Pain management', '2026-05-05', NULL, 'Active');


INSERT INTO Appointment(patient_id, doctor_id, appt_date, appt_time, status, reason, case_id) VALUES
(1, 1, '2026-05-21', '09:00:00', 'Scheduled', 'Chest pain follow-up', 1),
(2, 2, '2026-05-22', '10:30:00', 'Scheduled', 'Migraine consultation', 2);


INSERT INTO Admission(patient_id, doctor_id, room_id, admission_date, discharge_date, status, case_id) VALUES
(1, 1, 2, '2026-05-15', NULL, 'Admitted', 1);


INSERT INTO Medical_Record(patient_id, doctor_id, admission_id, diagnosis_date, symptoms, diagnosis, note) VALUES
(1, 1, 1, '2026-05-15', 'Chest pain, fatigue', 'Coronary artery disease', 'Patient under observation');

INSERT INTO Medication(med_name, dosage_form, unit, description, stock_qty) VALUES
('Paracetamol', 'Tablet', '500mg', 'Pain reliever', 100),
('Aspirin', 'Tablet', '100mg', 'Blood thinner', 50);


INSERT INTO Prescription(record_id, medication_id, frequency, duration, quantity) VALUES
(1, 2, 'Twice daily', '30 days', 60);


INSERT INTO Lab_Test(test_name, description, cost) VALUES
('Blood Test', 'Complete blood count', 500.00),
('MRI Scan', 'Brain MRI imaging', 3000.00);

INSERT INTO Lab_Order(patient_id, doctor_id, test_id, order_date, status) VALUES
(1, 1, 1, '2026-05-16', 'Pending'),
(2, 2, 2, '2026-05-17', 'Completed');


INSERT INTO Lab_Result(order_id, result_value, result_date, is_normal, notes) VALUES
(2, 'Normal', '2026-05-18', TRUE, 'No abnormalities detected');


INSERT INTO payment(patient_id, admission_id, amount, payment_date, payment_method, status) VALUES
(1, 1, 15000.00, '2026-05-18', 'Cash', 'Paid');


INSERT INTO Nurse(first_name, last_name, phone, email, dept_id, shift) VALUES
('Hana', 'Getachew', '0955000001', 'hana@gmail.com', 1, 'Day'),
('Firehiywot', 'Endalkachew', '0955000002', 'firehiywot@gmail.com', 2, 'Night');


SELECT *FROM Department;
SELECT *FROM Doctor;
SELECT *FROM Nurse;
SELECT * FROM Patient;


SELECT 
d.doctor_id, 
d.first_name, 
d.last_name, 
d.Specialization, 
dept.dept_name
FROM Doctor d
JOIN Department dept
ON d.dept_id = dept.dept_id;


SELECT
 a.appointment_id, 
 p.first_name AS patient,
 d.first_name AS doctor,
a.appt_date,
a.appt_time,
a.status
FROM Appointment a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id;


SELECT 
p.first_name, 
p.last_name,
r.room_no,
a.admission_date
FROM Admission a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Room r ON a.room_id = r.room_id;


SELECT
 pr.prescription_id,
 m.med_name,
 pr.frequency, 
 pr.duration
FROM Prescription pr
JOIN Medication m ON pr.medication_id = m.medication_id;


SELECT
 p.first_name, 
lt.test_name,
 lr.result_value
FROM Lab_Result lr
JOIN Lab_Order lo ON lr.order_id = lo.order_id
JOIN Patient p ON lo.patient_id = p.patient_id
JOIN Lab_Test lt ON lo.test_id = lt.test_id;

UPDATE Patient
SET phone = '0933999999'
WHERE patient_id = 1;

UPDATE Appointment
SET status = 'Completed'
WHERE appointment_id = 1;

UPDATE Medication
SET stock_qty = 80
WHERE medication_id = 1;

SELECT COUNT(*) AS total_doctors
FROM Doctor;

SELECT COUNT(*) AS total_patients
FROM Patient;

SELECT COUNT(*) AS total_nurses 
FROM Nurse;

SELECT AVG(cost) AS average_cost
FROM Lab_Test;

SELECT SUM(amount) AS total_revenue
FROM payment;

