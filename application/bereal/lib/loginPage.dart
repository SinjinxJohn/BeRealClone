import 'package:bereal/googleSingInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

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
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
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
            SizedBox(
              height: 300,
            ),
            // Text(
            //   'Click on the button to sign in with Google',
            //   style: GoogleFonts.lato(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w800,
            //       color: Colors.white),
            // ),
            InkWell(
              onTap: () {
                signInWithGoogle();
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
