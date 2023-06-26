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
     final height=MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    width: width*0.094,
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
              height: height*0.02,
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
                      height: height*0.98,
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
                                        height: height*0.043,
                                        width: width*0.09,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                       SizedBox(
                                        width: width*0.018,
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
                                          SizedBox(
                                            height: height*0.001,
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
                                      height: height*0.5,
                                      width: width*0.96,
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
                                      padding: EdgeInsets.only(
                                          left: width*0.03, top: height*0.01),
                                      child: Container(
                                        height: height*0.19,
                                        width: width*0.3,
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
