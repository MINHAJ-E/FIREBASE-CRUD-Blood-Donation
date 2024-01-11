// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:blood_donation/controller/edit_add_delete_provider.dart';
import 'package:blood_donation/controller/image_provider.dart';
import 'package:blood_donation/model/model.dart';
import 'package:blood_donation/view/widget/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  DonorModel donor;
  String id;
  EditPage({super.key, required this.donor, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  
  bool clicked = true;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.donor.name);
    ageController = TextEditingController(text: widget.donor.age);
    phoneController = TextEditingController(text: widget.donor.phone);
    placeController = TextEditingController(text: widget.donor.place);
    bloodGroupController = TextEditingController(text: widget.donor.bloodGroup);
    Provider.of<ImageProviderr>(context,listen: false).file=File(widget.donor.image??"");

  }
  String? selectedValue;
  List listItems = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "E D I T D O N O R ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: 
           Consumer<ImageProviderr>(
              builder: (context, value, child) => Column(
          children: [
            const SizedBox(
              height: 10,
            ),
         
               FutureBuilder<File?>(
                    future: Future.value(value.file),
                    builder: (context, snapshot) {
                      return CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 40,
                        backgroundImage:!clicked?FileImage(File(value.file!.path)):NetworkImage(value.file!.path)as ImageProvider,
                      );
                    },
                  ),
                   Row(
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        value.getCam(ImageSource.camera);
                      },
                      child: const Text('Camera'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        value.getCam(ImageSource.gallery);
                        clicked=!clicked;
                      },
                      child: const Text('Gallery'),
                    ),
                  ],
                ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "N A M E",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: placeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "P L A C E",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
               controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "P H O N E",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "A G E",
                ),
              ),
            ),
         const DropDown(),
            ElevatedButton(
              onPressed: () {
                update(widget.donor.image);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(  
                backgroundColor: Colors.amber,
              ),
              child: const Text("EDIT DONOR"),
            )
          ],
        ),
      ),
    ));
  }
    void update(imageurl)async {
      final providerr=Provider.of<ImageProviderr>(context,listen: false);
      final providerr2=Provider.of<AddDeleteProvider>(context,listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final place = placeController.text;
    final bloodGroup = bloodGroupController.text;
    await providerr.imageUpdate(imageurl,File( providerr.file!.path));
    final updated = DonorModel(
        name: name,
        age: age,
        phone: phone,
        bloodGroup: bloodGroup,
       place:place,
       image: providerr.downloadurl
       );
  //  updateDonator(widget.id, updated);
   providerr2.updateDonator(widget.id, updated);
  }
}
  

