// import 'dart:html';

import 'package:bereal/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  CollectionReference _collectionReference2 =
      FirebaseFirestore.instance.collection('discovery');

  late Stream<QuerySnapshot> collectionItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectionItem = _collectionReference2.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    _collectionReference2.get();
    _collectionReference2.snapshots();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.people_sharp),
          title:const Text(
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
          children: [
            SizedBox(
              height: 25,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: collectionItem,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> listQueryDocsSnapshot =
                        querySnapshot.docs;
                    return SizedBox(
                      height: 800,
                      child: ListView.builder(
                          itemCount: listQueryDocsSnapshot.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                listQueryDocsSnapshot[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.network(
                                            document['profile'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            document['name'],
                                            style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                textStyle: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            document['late'],
                                            style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                textStyle: TextStyle(
                                                    color: Colors.grey)),
                                          )
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      IconButton(
                                          onPressed: () {
                                            // ImagePicker imagepicker = ImagePicker();
                                            // XFile? file = await imagepicker.pickImage(
                                            //     source: ImageSource.camera);
                                          },
                                          icon: Icon(
                                            Icons.menu_outlined,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Stack(children: [
                                    Container(
                                      height: 500,
                                      width: 370,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.network(
                                          document['rear image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 10),
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black, width: 2)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.network(
                                            document['frontImage'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            );
                          }),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })
          ],
        ));
  }
}
