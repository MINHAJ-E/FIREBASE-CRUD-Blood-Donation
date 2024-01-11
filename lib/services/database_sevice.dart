import 'package:blood_donation/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String crudref = "donor";

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<DonorModel> donorsRef;
  Reference main = FirebaseStorage.instance.ref();

  DatabaseService() {
    donorsRef = firestore.collection(crudref).withConverter<DonorModel>(
          fromFirestore: (snapshot, _) => DonorModel.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
  }
}
