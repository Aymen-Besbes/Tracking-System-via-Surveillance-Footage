import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart' ;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool _isObscure3 = true;
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
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              final snackBar = SnackBar(content: Text(
                  "t's recommended to connect your email address for us to better protect your informations"
              ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column
          (mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DelayedAnimation(
              delay: 2500, child: logoWidget("images/logo.png"),),
            SizedBox(height: 35),
            LoginForm(),
            SizedBox(height: 40),
            DelayedAnimation(delay: 5500, child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 125,
                  vertical: 13,
                ),
              ),
              key: _formkey,
              child: Text(
                'LOG IN',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                setState(() {
                  visible = true;
                });
                signIn(emailController.text, passwordController.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (Context) => SignUpScreen(),
                  ),
                );
              },
            ),
            ),
            SizedBox(height: 22),
            DelayedAnimation(delay: 6500, child: signUpOption(context)
            ),
          ],

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
              builder: (context) =>  PickImage(),
            ),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  NormalUser(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

}
Image logoWidget(String imageName) {
  return Image.asset( imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 260,
    color: Colors.black,
  );
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();

}
class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(delay: 3500, child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'your Email',
              labelStyle: TextStyle(
                color: Colors.grey[400],
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
          SizedBox(height: 30),
          DelayedAnimation(delay: 4500, child: TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Colors.black,
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
        ],
      ),
    );
  }


}