import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart' ;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pcd_version_finale/utils/utils.dart';
import 'delayed_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pcd_version_finale/main.dart';
import 'signup_screen.dart';
import 'super_user_screen.dart';
import 'normal_user_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
//ajoutés
class _LoginPageState extends State<LoginPage> {
  var _obscureText = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  //fin ajout

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column
            (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              DelayedAnimation(
                delay: 2500,
                child: Transform.translate(
                  offset: Offset(0, -60),
                  // Déplace l'image de 10 pixels vers le haut
                  child: Image.asset("images/login1.png"),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 30,

                ),
                child: Column(
                  children: [
                    DelayedAnimation(delay: 3500,
                     child: Transform.translate(offset: Offset(0, -80),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Your Email',
                            suffixIcon: Icon(
                                Icons.email, color: Colors.black54),
                            labelStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                     ),
                    ),
                    SizedBox(height: 30),
                    DelayedAnimation(delay: 4500,
                      child: Transform.translate(offset: Offset(0, -80),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),

                      ),
                    ),
                  ],
                ),
              )
              ,
              SizedBox(height: 40),
              DelayedAnimation(delay: 5500,
              child: Transform.translate(offset: Offset(0, -70),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(
                        horizontal: 125,
                        vertical: 13,
                      ),
                    ),

                    child: Text(
                      'LOG IN',
                      style: kButtonTextStyle,
                    ),
                    onPressed: () {
                      setState(() {
                        visible = true;
                      });
                      signIn(emailController.text, passwordController.text);
                      //Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context) => SignUpScreen(),),);
                    },
                 ),
                ),
              ),
              DelayedAnimation(delay: 6500,
                child: Transform.translate(offset: Offset(0, -45),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            "Don't have an account?", style: TextStyle(color: Colors.grey,fontSize: 15)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize:20,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              )

            ],

          ),
        ),
      ),
    );
  }

  Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
            "Don't have an account?", style: TextStyle(color: Colors.grey)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Super User") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PickImage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NormalUser(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }





}