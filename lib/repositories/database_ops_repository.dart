import 'package:firebase_database/firebase_database.dart';
import '../utils/constants.dart';

class DatabaseOpsRepository {
  final FirebaseDatabase _db;

  DatabaseOpsRepository() : _db = FirebaseDatabase.instance;

  Stream<DatabaseEvent> get params => _db.ref(paramsField).onValue;

  Stream<DatabaseEvent> get topValve =>
      _db.ref(paramsField).child(topValveField).onValue;

  Stream<DatabaseEvent> get bottomValve =>
      _db.ref(paramsField).child(bottomValveField).onValue;

// num readSlider(DataSnapshot dataSnapshot) => dataSnapshot.value as num;
//
// Future<void> writeSlider(num newStatusValue) async {
//   await _db.ref(testRef).update({
//     sliderField: newStatusValue,
//   });
// }
//
// bool readStatus(DataSnapshot dataSnapshot) =>
//     (dataSnapshot.value as num) != 0;
//
// Future<void> writeStatus(num newStatusValue) async {
//   await _db.ref(testRef).update({
//     statusField: newStatusValue != nil ? nil : one,
//   });
// }
}
