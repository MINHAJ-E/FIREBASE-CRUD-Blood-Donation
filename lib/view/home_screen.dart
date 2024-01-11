// ignore_for_file: use_key_in_widget_constructors

import 'package:blood_donation/controller/edit_add_delete_provider.dart';
import 'package:blood_donation/controller/home_provider.dart';
import 'package:blood_donation/controller/image_provider.dart';
import 'package:blood_donation/model/model.dart';
import 'package:blood_donation/view/add_page.dart';
import 'package:blood_donation/view/edit_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference items =
      FirebaseFirestore.instance.collection("donor");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLOOD DONATION"),
        backgroundColor: Colors.yellow,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) =>
            StreamBuilder<QuerySnapshot<DonorModel>>(
          stream: value.getDatas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<QueryDocumentSnapshot<DonorModel>> donatorDocs =
                snapshot.data?.docs ?? [];

            return ListView.builder(
              itemCount: donatorDocs.length,
              itemBuilder: (context, index) {
                DonorModel donor = donatorDocs[index].data();
                final id = donatorDocs[index].id;

                return Card(
                  color: Colors.teal,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(donor.image!),
                    ),
                    title: Text(donor.name!),
                    subtitle: Text(donor.place!),
                    trailing: SizedBox(
                      width: 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(donor.bloodGroup!),
                            IconButton(
                              onPressed: () {
                                Provider.of<AddDeleteProvider>(context,
                                        listen: false)
                                    .deleteDonator(id);
                                Provider.of<ImageProviderr>(context,
                                        listen: false)
                                    .deleteImage(donor.image!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        EditPage(donor: donor, id: id)));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const AddPage()));
        },
      ),
    );
  }

  // Future<void> delete(String prodectId) async {
  //   await items.doc(prodectId).delete();
  // }
}
