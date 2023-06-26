import 'package:bereal/googleSingInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool login = false;
  bool _isloading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _email.text.toString();
    final password = _password.text.toString();

    setState(() {
      _isloading = true;
    });

    if (login) {
      await Auth().signInWithEmailandPassword(email, password);
    } else {
      await Auth().registerWithEmailandPassword(email, password);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  height: height*0.2,
                ),
                Text(
                  "BeReal.",
                  style: GoogleFonts.lato(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                Text(
                  "Where you can be the real you",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey),
                ),
                 SizedBox(
                  height: height*0.24,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width*0.1, right: width*0.1),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          // margin: EdgeInsets.all(),
                          behavior: SnackBarBehavior.floating,
                          // width: 100,

                          elevation: 30,
                          duration: const Duration(seconds: 1),

                          backgroundColor: Colors.red,
                          // showCloseIcon: ,

                          content: Row(children: [
                            const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                                child: Text(
                              "Email cannot be empty",
                              style: const TextStyle(color: Colors.white),
                            ))
                          ]),
                        ));
                      }
                      return null;
                    },
                    controller: _email,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        focusColor: Colors.grey,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 30),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        )),
                        labelText: "Email",
                        labelStyle: GoogleFonts.lato(color: Colors.white),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height:height*0.02 ,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width*0.1, right: width*0.1),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          // margin: EdgeInsets.all(),
                          behavior: SnackBarBehavior.floating,
                          // width: 100,

                          elevation: 30,
                          duration: const Duration(seconds: 1),

                          backgroundColor: Colors.red,
                          // showCloseIcon: ,

                          content: Row(children: [
                            const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                                child: Text(
                              "Password cannot be empty",
                              style: const TextStyle(color: Colors.white),
                            ))
                          ]),
                        ));
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    controller: _password,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 30),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        )),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        )),
                        labelText: "Password",
                        labelStyle: GoogleFonts.lato(color: Colors.white),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                InkWell(
                  onTap: () {
                    if(_email.text.isEmpty||_password.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          // margin: EdgeInsets.all(),
                          behavior: SnackBarBehavior.floating,
                          // width: 100,

                          elevation: 30,
                          duration: const Duration(seconds: 1),

                          backgroundColor: Colors.red,
                          // showCloseIcon: ,

                          content: Row(children: [
                            const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                                child: Text(
                              "Email/password cannot be empty",
                              style: const TextStyle(color: Colors.white),
                            ))
                          ]),
                        ));

                    }else{
                      onSubmit();
                    }
                  }
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

                  // signInWithGoogle();
                  ,
                  child: _isloading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            height: height*0.06,
                            width: width*0.4,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                  child: Text(
                                login ? 'LOGIN' : 'Register',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              )),
                              // color: Colors.white,
                            ),
                          ),
                        ),
                ),
                // SizedBox(
                //   height: height*0.01,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => HomePage()));
                //     // signInWithGoogle();
                //   },
                //   child: Center(
                //     child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.white),
                //       height: 50,
                //       width: 200,
                //       child: Center(
                //           child: Text(
                //         'Sign In With Google',
                //         style: GoogleFonts.lato(
                //             fontSize: 17, fontWeight: FontWeight.w700),
                //       )),
                //       // color: Colors.white,
                //     ),
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "Not a user?",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     TextButton(
                //         onPressed: () {

                //         },
                //         child: const Text(
                //           "SignUp",
                //           style: TextStyle(
                //               color: Colors.white, fontWeight: FontWeight.bold),
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // signInWithGoogle() async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //   AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   print(userCredential.user?.displayName);
  // }
}
