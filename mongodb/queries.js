print("Initializing Hospital Database Collection.")
db.createCollection("patients");
db.createCollection("staff");
db.createCollection("inventory");
print("Hospital Database COllection Initialized Successfully.\n");

//Query A: Find Night shift Nurses in Internal Medicine
db.staff.find({
  "role": "Nurse",
  "shift": "Night",
  "department.dept_name": "Internal Medicine"
});

//Query B: calculate total unpaid bills Hospital-Wide
db.patients.aggregate([
  { $unwind: "$billings" },
  { $match: { "billings.status": "Unpaid" } },
  { $group: { _id: null, totalOwed: { $sum: "billings.amount"} } }
  ]);

//Query C:Decrement Inventory Stock when Medication is Dispensed
db.inventory.updateOne(
  { "med_name": "Amoxicillin" },
  { $inc: { "stock_qty": -1 } }
  );
print("Stock updated. Verifying new stock:");
db.inventory.findOne({"med_name": "Amoxicillin"}, { "stock_qty": 1 });

//Query D:Get patient emergency contact details
db.patients.find(
  { "first_name": "Abebe", "last_name": "Bikila" },
  {
    "first_name": 1,
    "last_name": 1,
    "vitals.emergency_contact": 1,
    "vitals.emergency_phone": 1
  }
);
  
