db.createCollection("patients");
db.createCollection("staff");
db.createCollection("inventory");

print("Hospital Database Collections Initalized Successfully.");
db.staff.find({
  "role": "Nurse",
  "shift": "Night",
  "department.dept_name":"Internal Medicine"
});
db.paients.aggregate([
  { $match:{ "billing.status": "Unpaid" }},
  { $group: { _id: null, totalOwed: { $sum: "$billing.total" } } }
]);
db.pharmacy.updateOne(
    { "med_name": "Amoxicillin" },
    { $inc: { "stock_qty": -1 } }
);
db.patients.find(
  {"name": "Abebe Bikila" },
  {"name":1,"vitals.emergency_contact": 1, "vitals.emergency_phone":1}
  );
