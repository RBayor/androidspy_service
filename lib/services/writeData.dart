import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class WriteData {
  Firestore db = new Firestore();

  Future<void> addData(col, data) async {
    CollectionReference ref = Firestore.instance.collection(col);
    ref.add(data);
  }

  Future addLocation(col, doc, lat, lng) async {
    DocumentReference ref = Firestore.instance.collection(col).document(doc);
    ref.setData({"lat": lat, "lng": lng});
  }
}
