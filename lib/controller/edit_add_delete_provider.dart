import 'package:blood_donation/model/model.dart';
import 'package:blood_donation/services/database_sevice.dart';
import 'package:flutter/material.dart';

class AddDeleteProvider extends ChangeNotifier{
  DatabaseService services = DatabaseService();
    Future<void> addDonator(DonorModel data) async {
    await services.donorsRef.add(data);
    notifyListeners();
  }
   Future<void> updateDonator(id, DonorModel doners) async {
    services.donorsRef.doc(id).update(doners.toJson());
    notifyListeners();
  }
   Future<void> deleteDonator(id) async {
    services.donorsRef.doc(id).delete();
    notifyListeners();
  }
}