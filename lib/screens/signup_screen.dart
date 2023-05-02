import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart' ;
import 'super_user_screen.dart';
import 'delayed_animation.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  var _obscureText = true;
  bool _isType1Selected = false;
  bool _isType2Selected = false;

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
            DelayedAnimation(delay: 3500, child: TextField(


              decoration: InputDecoration(
                labelText: 'Address mail',

                suffixIcon: Icon(Icons.email , color: Colors.black),
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ),

            // Adresse email


            // Mot de passe
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextField(

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
            ),
            ),
            SizedBox(height: 15) ,
            DelayedAnimation(delay: 3500, child: TextField(

              obscureText: _obscureText,

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
                  //if (_isType1Selected) {
                  //  Navigator.push(context, MaterialPageRoute(builder: (Context) =>   )
                  //  );
                  // }
                  if (_isType2Selected) {
                    Navigator.push(context, MaterialPageRoute (builder: (Context) =>PickImage()  )
                    );
                  }
                }

            ),
            ),
          ],
        ),
      ),
    );
  }

}