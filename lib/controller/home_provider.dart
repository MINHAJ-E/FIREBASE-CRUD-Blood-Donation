import 'package:blood_donation/model/model.dart';
import 'package:blood_donation/services/database_sevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  DatabaseService services = DatabaseService();
  Stream<QuerySnapshot<DonorModel>> getDatas() {
    return services.donorsRef.snapshots();
  }
}
