import 'dart:async';
import 'dart:io';

import 'package:bereal/discovery.dart';
import 'package:bereal/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = '';
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('images');
  late Stream<QuerySnapshot> imageItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageItems = collectionReference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    collectionReference.get();
    collectionReference.snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: Icon(Icons.people_sharp),
        title: Text(
          "BeReal.",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Container(
                  child: Icon(Icons.person),
                  // height: 3,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My Friends",
                style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Discovery()));
                },
                child: Text("Discovery",
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(color: Colors.white))),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),

          StreamBuilder<QuerySnapshot>(
              stream: imageItems,
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  QuerySnapshot _querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> listQueryDocsSnapshot2 =
                      _querySnapshot.docs;
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listQueryDocsSnapshot2.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot document2 =
                              listQueryDocsSnapshot2[index];
                          return Center(
                            child: Stack(children: [
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Image.network(
                                      document2['rearimage'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 150,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.white),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 8.0, top: 10),
                              //   child: Container(
                              //     // child: ClipRRect(
                              //     //   borderRadius: BorderRadius.circular(9),
                              //     //   child: Image.network(
                              //     //     document2['rearimage'],
                              //     //     fit: BoxFit.cover,
                              //     //   ),

                              //     height: 40,
                              //     width: 30,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(9),
                              //         color: Colors.green,
                              //         border: Border.all(
                              //             color: Colors.black, width: 2)),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 30,
                              // )
                            ]),
                          );
                        }),
                  );
                }
                if (!snapshot.hasData) {
                  Text(
                    "Please Upload photo to BeReal",
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 25),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })),
          SizedBox(
            height: 150,
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: Text(
                "Your friends haven't posted their BeReal yet. Add even",
                style: GoogleFonts.lato(fontSize: 25, color: Colors.white70),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 110.0),
            child: Center(
              child: SizedBox(
                width: 300,
                child: Text(
                  "more friends",
                  style: GoogleFonts.lato(fontSize: 25, color: Colors.white70),
                ),
              ),
            ),
          ),

          // const SizedBox(
          //   height: 14,
          // ),
          Expanded(child: Container()),
          Center(
            child: InkWell(
              onTap: () async {
                ImagePicker imagepicker = ImagePicker();
                XFile? file = await imagepicker.pickImage(
                    source: ImageSource.camera,
                    preferredCameraDevice: CameraDevice.front);
                print('${file?.path}');

                if (file == null) return;

                String filename =
                    DateTime.now().millisecondsSinceEpoch.toString();
                //get a reference to storage root
                Reference referenceroot = FirebaseStorage.instance.ref();
                Reference referencefolderimages = referenceroot.child('images');

                //creating a refrence for the image to be stored
                Reference imagetoupload = referencefolderimages.child(filename);

                //store the file
                try {
                  await imagetoupload.putFile(File(file.path));
                  imageUrl = await imagetoupload.getDownloadURL();
                } catch (error) {}
                if (imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please upload an image")));
                }
                Map<String, dynamic> datatosave = {
                  'name': 'sins',
                  'rearimage': imageUrl,
                  'uploadTime': DateTime.now(),
                  'expiryTime': DateTime.now().add(Duration(hours: 1))
                };
                FirebaseFirestore.instance.collection("images").add(datatosave);
                void deleteExpiredDocuments() async {
                  DateTime currentTime = DateTime.now();

                  final querySnapshot = await FirebaseFirestore.instance
                      .collection("images")
                      .where('expirationTime', isLessThan: currentTime)
                      .get();

                  querySnapshot.docs.forEach((doc) {
                    doc.reference.delete();
                  });
                }

                void startTimerToDeleteExpiredDocuments() {
                  Timer.periodic(Duration(hours: 1), (timer) {
                    deleteExpiredDocuments();
                  });
                }

// Start the timer when needed
                startTimerToDeleteExpiredDocuments();
              },
              child: const Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 90,
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 135),
          //   child: IconButton(
          //       onPressed: () {
          //         // ImagePicker imagepicker = ImagePicker();
          //         // XFile? file =
          //         //     await imagepicker.pickImage(source: ImageSource.gallery);
          //         // print("button was clicked");
          //       },
          //       icon: const Icon(
          //         Icons.circle_outlined,
          //         color: Colors.white,
          //         size: 90,
          //       )),
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Post a Late BeReal.",
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }
}
