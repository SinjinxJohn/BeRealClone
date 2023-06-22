import 'package:bereal/googleSingInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
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
              const SizedBox(
                height: 250,
              ),
             Padding(
                padding: EdgeInsets.only(left: 40,right: 40),
                child: TextField(
                
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    
                    filled: true,
                    fillColor: Colors.black,
                    focusColor: Colors.grey,
                    contentPadding: EdgeInsets.symmetric(vertical: 9,horizontal: 30),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.white,)),
                      labelText: "Email",
                      labelStyle:GoogleFonts.lato(color: Colors.white) ,
                      
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                       border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 15,),
               Padding(
                padding: EdgeInsets.only(left: 40,right: 40),
                child: TextField(
                
                
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                  
                    filled: true,
                    fillColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(vertical: 9,horizontal: 30),
                      enabledBorder: const OutlineInputBorder(
                        
                        
                        
                          borderSide:
                              BorderSide(width: 2, color: Colors.white,)),
                      labelText: "Password",
                      labelStyle: GoogleFonts.lato(color: Colors.white),
                      

                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none
                      ),
                ),
              ),
        
              
            
             
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  // signInWithGoogle();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    height: 50,
                    width: 200,
                    child: Center(
                        child: Text(
                      'Login In',
                      style: GoogleFonts.lato(color: Colors.white,
                          fontSize: 17, fontWeight: FontWeight.w700),
                    )),
                    // color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  // signInWithGoogle();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 50,
                    width: 200,
                    child: Center(
                        child: Text(
                      'Sign In With Google',
                      style: GoogleFonts.lato(
                          fontSize: 17, fontWeight: FontWeight.w700),
                    )),
                    // color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }
}
