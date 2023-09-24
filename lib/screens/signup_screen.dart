import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pcd_version_finale/utils/utils.dart';
import'login_screen.dart';
import 'delayed_animation.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {

 //Greetings


  _SignUpScreenState();
  bool showProgress = false;
  bool visible = false;
  var _obscureText = true;
  bool _isType1Selected = false;
  bool _isType2Selected = true;

  //ajoutés
  File? file;
  var options= [
    'Super User',
    'Normal User',
  ];
  var rool="";
  final _formkey= GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  final TextEditingController passwordController= new TextEditingController();
  final TextEditingController confirmpasswordcontroller=new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController LocationController=new TextEditingController();
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text("Sign Up",style: TextStyle(fontSize: 30),),
        elevation: 0,
        backgroundColor:  Colors.deepPurple,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          //   Icon(Icons.favorite),
          //Padding(
            //padding: EdgeInsets.symmetric(horizontal: 16),
            //child: Icon(Icons.search),
          //),
          //Icon(Icons.more_vert),
        ],
        centerTitle: true,
      ),

      body:

        SingleChildScrollView(


        padding: EdgeInsets.all(16.0),
        child: Form(
          key:_formkey,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nom
            SizedBox(height: 5) ,
            DelayedAnimation(delay: 3500, child: TextField(



              decoration: InputDecoration(
                labelText: 'Name',

                suffixIcon: Icon(Icons.person , color: Colors.black54),

                labelStyle: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            ),
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Address mail',
                suffixIcon: Icon(Icons.email , color: Colors.black54),
                labelStyle: TextStyle(
                  color: Colors.black54,
                ),
              ),
              validator: (value){
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
              onChanged: (value) {},
              keyboardType: TextInputType.emailAddress,
            ),
            ),



            // Mot de passe
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextFormField(
              controller: passwordController,
              obscureText: _obscureText,

              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  color: Colors.black54,

                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;

                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                ),

                labelStyle: TextStyle(
                  color: Colors.black54,
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
              onChanged: (value) {},
            ),
            ),
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextFormField(

              obscureText: _obscureText,
              controller: confirmpasswordcontroller,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                suffixIcon: IconButton(

                  color: Colors.black54,

                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;

                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                ),
                labelStyle: TextStyle(
                  color: Colors.black54,
                ),
              ),
              validator: (value) {
                if (confirmpasswordcontroller.text !=
                    passwordController.text) {
                  return "Password did not match";
                } else {
                  return null;
                }
              },
              onChanged: (value) {},
            ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: DelayedAnimation(
                    delay: 3500,
                    child: CheckboxListTile(
                      title: Text('Super User'),
                      value: _isType2Selected,
                      onChanged: (bool? value) {
                        setState(() {
                          _isType2Selected = value ?? false;
                          _isType1Selected = !(_isType2Selected);
                          if (_isType2Selected) {
                            rool = "Super User";
                          }
                        });
                      },
                      activeColor: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DelayedAnimation(
                    delay: 3500,
                    child: CheckboxListTile(
                      title: Text('Normal User'),
                      value: _isType1Selected,
                      onChanged: (bool? value) {
                        setState(() {
                          _isType1Selected = value ?? false;
                          _isType2Selected = !(_isType1Selected);
                          if (_isType1Selected) {
                            rool = "Normal User";
                          }
                        });
                      },
                      activeColor: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),

            // Champs pour le type d'utilisateur 1
            if (_isType1Selected)

          Column(
          children: [
            SizedBox(height: 10),
          TextFormField(
            controller: LocationController,
            decoration: InputDecoration(
            labelText: 'Enter your location ',
            suffixIcon: IconButton(
               icon: Icon(Icons.location_on), onPressed: () {  },

          ),
          labelStyle: TextStyle(
          color: Colors.black54,
          ),
          ),
          ),
          SizedBox(height: 15),
          TextField(

          decoration: InputDecoration(
          labelText: 'Enter the number of cameras ',
            suffixIcon: Icon(Icons.camera , color: Colors.black54),
          labelStyle: TextStyle(
          color: Colors.black54,
          ),
          ),
          ),
          ],
          ),

          // Checkbox pour le type d'utilisateur 2


          // Champs pour le type d'utilisateur 2


            // Bouton pour valider le formulaire
            SizedBox(height :40),
            DelayedAnimation(delay: 5500, child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary:Colors.deepPurple,
                  padding: EdgeInsets.symmetric(
                    horizontal:125,
                    vertical: 13,
                  ),
                ),
                 onPressed: () {
                      setState(() {
                        showProgress = true;
                       });
                      signUp(emailController.text,passwordController.text , rool);
                        },
                child: Text(
                  'Confirm',
                  style: kButtonTextStyle
                ),


            ),
            ),
          ],
        ),
      ),
    )
    );
  }
  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) { print ("erreur1");});
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    if (rool == 'Normal User') {
      ref.doc(user!.uid).set({
        'email': emailController.text,
        'rool': rool,
        'location': LocationController.text, // Add location field
      });
    }
    else if (rool=='Super User')
    {

      ref.doc(user!.uid).set({'email':emailController.text,'rool': rool});

    }
    Navigator.pushReplacement(
        context , MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
