// import 'dart:developer';
import 'dart:io';
import 'package:blood_donation/services/database_sevice.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderr extends ChangeNotifier {
  DatabaseService service = DatabaseService();
  String imagename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = "";
  File? file;
  ImagePicker image = ImagePicker();
  Future<void> getCam(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }

  imageAdder(image) async {
    try {
      Reference imagefolder = service.main.child('images');
      Reference uploadimage = imagefolder.child("$imagename.jpg");
      await uploadimage.putFile(image);
      downloadurl = await uploadimage.getDownloadURL();
      notifyListeners();
    } catch (error) {
      return Exception('image cant be added $error');
    }
    notifyListeners();
  }

  imageUpdate(imageurl, updatedimage) async {
    try {
      Reference editpic = FirebaseStorage.instance.refFromURL(imageurl);
      await editpic.putFile(updatedimage);
      downloadurl = await editpic.getDownloadURL();
      notifyListeners();
    } catch (error) {
      return Exception('image is not updated$error');
    }
    notifyListeners();
  }

  deleteImage(imageurl) async {
    try {
      Reference delete = FirebaseStorage.instance.refFromURL(imageurl);
      await delete.delete();
      notifyListeners();
    } catch (error) {
      return Exception('image is not deleted $error');
    }
    notifyListeners();
  }
}
