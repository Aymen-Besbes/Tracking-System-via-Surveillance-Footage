import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart' ;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'delayed_animation.dart';
import 'package:pcd_version_finale/main.dart';
import 'signup_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
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
        actions:[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              final snackBar = SnackBar(content: Text("t's recommended to connect your email address for us to better protect your informations"
              ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),],
      ),

      body:SingleChildScrollView(
        child :Column(mainAxisAlignment: MainAxisAlignment.center,
          children : <Widget> [ DelayedAnimation (delay :2500 , child :logoWidget("images/logo.png"),),

            SizedBox(height:35),
            LoginForm(),
            SizedBox(height :40),
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
                'LOG IN',
                style: GoogleFonts.poppins(
                  color:Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (Context) => MyApp(),
                  ),
                );
              } ,
            ),
            ),
            SizedBox(height: 22),
            DelayedAnimation(delay: 6500, child:  signUpOption(context)
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
        const Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(delay: 3500, child: TextField(
            decoration: InputDecoration(
              labelText: 'your Email',
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
          ),
          SizedBox(height: 30),
          DelayedAnimation(delay: 4500, child: TextField(
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
          ),
          ),
        ],
      ),
    );
  }

}