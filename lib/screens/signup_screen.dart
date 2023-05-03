import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pcd_version_finale/screens/normal_user_screen.dart';
import 'super_user_screen.dart';
import'login_screen.dart';
import 'delayed_animation.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  _SignUpScreenState();
  bool showProgress = false;
  var _obscureText = true;
  bool _isType1Selected = false;
  bool _isType2Selected = false;

  //ajoutés
  var rool="";
  final _formkey= GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  final TextEditingController passwordController= new TextEditingController();
  final TextEditingController confirmpasswordcontroller=new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  Colors.red,
        title: Text('SIGN UP',
          style: GoogleFonts.poppins(
            color:Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          //   Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nom
            SizedBox(height: 5) ,
            DelayedAnimation(delay: 3500, child: TextField(



              decoration: InputDecoration(
                labelText: 'Name',

                suffixIcon: Icon(Icons.person , color: Colors.black),

                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ),
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Address mail',
                suffixIcon: Icon(Icons.email , color: Colors.black),
                labelStyle: TextStyle(
                  color: Colors.black,
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

            // Adresse email


            // Mot de passe
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextFormField(
              controller: passwordController,
              obscureText: _obscureText,

              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  color: Colors.black,

                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;

                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                ),

                labelStyle: TextStyle(
                  color: Colors.black,
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

                  color: Colors.black,

                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;

                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
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
            DelayedAnimation( delay: 3500, child:
            CheckboxListTile(

              title: Text('Super User'),
              value: _isType2Selected,
              onChanged: (bool? value) {
                setState(() {
                  _isType2Selected = value ?? false;
                  _isType1Selected = ! (_isType2Selected);
                if(_isType2Selected){rool="Super User";};
                });

              },
              activeColor: Colors.black,


            ),

            ),


            SizedBox(height: 15),
            // Checkbox pour le type d'utilisateur 1
            DelayedAnimation(delay: 3500, child: CheckboxListTile(
              title: Text('Normal User'
              ),
              value: _isType1Selected,
              onChanged: (bool? value){
                setState(() {
                  _isType1Selected = value ?? false;
                  _isType2Selected = !(_isType1Selected);
                  if (_isType1Selected)
                    {rool = "Normal User";} ;
                });
              },
              activeColor: Colors.black,
            ),
            ),
            // Champs pour le type d'utilisateur 1
            if (_isType1Selected)
              Column(
                children: [
                  TextField(


                    decoration: InputDecoration(

                      labelText: 'Enter your location ',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  TextField(

                    decoration: InputDecoration(
                      labelText: 'Enter the numbre of cameras ',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),

            // Checkbox pour le type d'utilisateur 2



            // Champs pour le type d'utilisateur 2
            if (_isType2Selected)

              Column(
                children: [
                  // champs spécifiques pour le type d'utilisateur 2
                ],
              ),

            // Bouton pour valider le formulaire
            SizedBox(height :30),
            DelayedAnimation(delay: 5500, child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary:Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal:125,
                    vertical: 13,
                  ),
                ),
                child: Text(
                  'CONFIRM',
                  style: GoogleFonts.poppins(
                    color:Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showProgress = true;
                  });
                  signUp(emailController.text,passwordController.text , rool);
                  //if (_isType1Selected) {
                  //  Navigator.push(context, MaterialPageRoute(builder: (Context) =>   )
                  //  );
                  // }
                  if (rool=="Super User") {
                    Navigator.push(context, MaterialPageRoute (builder: (Context) =>PickImage()  )
                    );
                  }
                  else
                    if (rool=="Normal User"){
                    Navigator.push(context, MaterialPageRoute (builder: (Context) =>NormalUser()  )
                    );
                    };
                }

            ),
            ),
          ],
        ),
      ),
    );
  }
  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
