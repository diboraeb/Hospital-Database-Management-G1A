db.createCollection("patients");
db.createCollection("staff");
db.createCollection("inventory");
print("Hospital Database COllection Initialized Successfully.");
db.staff.find({
  "role": "Nurse",
  "shift": "Night",
  "department.dept_name": "Internal Medicine"
});
db.patients.aggregate([
  { $unwind: "$billings" },
  { $match: { "billings.status": "Unpaid" } },
  { $group: { _id: null, totalOwed: { $sum: "billings.amount"} } }
  ]);
db.inventory.updateOne(
  { "med_name": "Amoxicillin" },
  { $inc: { "stock_qty": -1 } }
  );
db.patients.find(
  { "first_name": "Abebe", "last_name": "Bikila" },
  {
    "first_name": 1,
    "last_name": 1,
    "vitals.emergency_contact": 1,
    "vitals.emergency_phone": 1
  }
);
  
