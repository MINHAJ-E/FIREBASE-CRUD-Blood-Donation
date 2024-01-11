import 'dart:io';

import 'package:blood_donation/controller/dropdown_provider.dart';
import 'package:blood_donation/controller/edit_add_delete_provider.dart';
import 'package:blood_donation/controller/image_provider.dart';
import 'package:blood_donation/model/model.dart';
import 'package:blood_donation/view/widget/drop_down.dart';
import 'package:blood_donation/view/widget/image_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController(); 
  TextEditingController phoneController = TextEditingController(); 
  TextEditingController placeController = TextEditingController(); 
  TextEditingController bloodGroupController = TextEditingController(); 
  String? selectedValue;
  List listItems = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  File? selectedimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "D O N O R ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            imageprofile(context),
            // const CircleAvatar(
            //   radius: 55,      
            // ),
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
                addData(context);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(  
                backgroundColor: Colors.amber,
              ),
              child: const Text("ADD DONOR"),
            )
          ],
        ),
      ),
    );
  }
   addData(BuildContext context) async{
    final providerr=Provider.of<ImageProviderr>(context,listen: false);
    final providerr2=Provider.of<AddDeleteProvider>(context,listen: false);
    final providerr3=Provider.of<DropdownProvider>(context,listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final place = placeController.text;
    final bloodGroup = providerr3.selectedGroups;
     await providerr.imageAdder(File(providerr.file!.path));
    final data = DonorModel(
        name: name, age: age, phone: phone, bloodGroup: bloodGroup, place:place,image:  providerr.downloadurl);
    providerr2.addDonator(data);
    providerr.file=null;
    // await DatabaseService().donorsRef.add(data);
   
  }

//    imageprofile(context) {
//   return Stack(
//     children: [
//     FutureBuilder<File?>(
//           future: Future.value(Provider.of<ImageProviderr>(context).file),
//           builder: (context, snapshot) {
//             return CircleAvatar(
//               backgroundColor: Colors.grey,
//               radius: 70,
//               backgroundImage:
//                   snapshot.data != null ? FileImage(snapshot.data!) : null,
//             );
//           },
//         ),
//       Positioned(
//         bottom: 30.0,
//         right: 30.0,
//         child: InkWell(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (context) => bottomsheet(),
//             );
//           },
//           child: const Icon(
//             Icons.camera_alt,
//             color: Colors.teal,
//           ),
//         ),
//       )
//     ],
//   );
// }

//   bottomsheet() {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(context).size.width,
//       margin:const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(
//         children: [
//         const Text(
//             "choose profile photo",
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           ),
//           // SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FloatingActionButton(
//                 onPressed: () {
//                  Provider.of<ImageProviderr>(context, listen: false)
//                             .getCam(ImageSource.camera);
//                 },
//                 tooltip: 'Open Camera',
//                 child: const Icon(Icons.camera),
//               ),
//               const SizedBox(
//                 width: 40,
//               ),
//               FloatingActionButton(
//                 onPressed: () {
//                Provider.of<ImageProviderr>(context, listen: false)
//                             .getCam(ImageSource.gallery);
//                 },
//                 tooltip: 'Open Gallery',
//                 child: const Icon(Icons.image),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
  // fromgallery() async {
  //   final returnedimage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     selectedimage = File(returnedimage!.path);
  //   });
  // }

  // fromcam() async {
  //   final returnedimage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //     selectedimage = File(returnedimage!.path);
  //   });
  // }
  }

