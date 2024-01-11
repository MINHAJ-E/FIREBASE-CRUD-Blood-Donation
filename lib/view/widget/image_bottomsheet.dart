
   import 'dart:io';
// import 'dart:js';

import 'package:blood_donation/controller/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

imageprofile(context) {
  return Stack(
    children: [
    FutureBuilder<File?>(
          future: Future.value(Provider.of<ImageProviderr>(context).file),
          builder: (context, snapshot) {
            return CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 70,
              backgroundImage:
                  snapshot.data != null ? FileImage(snapshot.data!) : null,
            );
          },
        ),
      Positioned(
        bottom: 30.0,
        right: 30.0,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => bottomsheet(context),
            );
          },
          child: const Icon(
            Icons.camera_alt,
            color: Colors.teal,
          ),
        ),
      )
    ],
  );
}

  bottomsheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin:const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
        const Text(
            "choose profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          // SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                 Provider.of<ImageProviderr>(context, listen: false)
                            .getCam(ImageSource.camera);
                },
                tooltip: 'Open Camera',
                child: const Icon(Icons.camera),
              ),
              const SizedBox(
                width: 40,
              ),
              FloatingActionButton(
                onPressed: () {
               Provider.of<ImageProviderr>(context, listen: false)
                            .getCam(ImageSource.gallery);
                },
                tooltip: 'Open Gallery',
                child: const Icon(Icons.image),
              ),
            ],
          )
        ],
      ),
    );
  }