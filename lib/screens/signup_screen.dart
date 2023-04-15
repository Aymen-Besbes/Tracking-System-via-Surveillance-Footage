import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart' ;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'delayed_animation.dart';
import 'package:pcd_version_finale/main.dart';
import 'package:email_validator/email_validator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  bool _isLocalOwner = false;
  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '';
  String _confirmPassword = '';
  int _nbCameras = 0;
  String _address = '';
  String _locationOption = '';
  bool _currentLocation= false;

  @override

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),

      child: Form(
        key: _formKey,
        child : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child : Card(

            child: Column(
              children:[
                _buildUserType(),
                SizedBox(height: 30),
                _buildUsername(),
                SizedBox(height: 30),
                _buildEmail(),
                SizedBox(height: 30),
                _buildPhoneNumber(),
                SizedBox(height: 30),
                _buildPassword(),
                SizedBox(height: 30),
                _buildConfirmPassword(),
                SizedBox(height: 30),
                if (_isLocalOwner) ...[
                  _buildNbCameras(),
                  SizedBox(height: 30),
                  _buildAddress(),
                  SizedBox(height: 30),
                  _buildLocationOption(),
                  SizedBox(height: 30),
                ],
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 125,
                      vertical: 13,
                    ),
                  ),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // handle sign up
                    }
                  },
                ),
              ],
            ),

          ),
        ),
      ),

    );
  }

  Widget _buildUserType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          value: false,
          groupValue: _isLocalOwner,
          onChanged: (value) {
            setState(() {
              _isLocalOwner = value!;
            });
          },
        ),
        Text('Super User'),
        Radio(
          value: true,
          groupValue: _isLocalOwner,
          onChanged: (value) {
            setState(() {
              _isLocalOwner = value!;
            });
          },
        ),
        Text('Local Owner'),
      ],
    );
  }

  Widget _buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Mot de passe est obligatoire.';
        }
        return null;
      },
      onSaved: (value) {
        _username = value!;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }
  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
      onSaved: (value) {
        _phoneNumber = value!;
      },
    );
  }
  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      onSaved: (String? value) {
        _password = value!;
      },
    );
  }
  Widget _buildConfirmPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter confirm password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Adresse'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Adresse est obligatoire.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _address = value;
        });
      },
    );
  }
  Widget _buildLocationOption() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _currentLocation,
          onChanged: (value) {
            setState(() {
              _currentLocation = value!;
            });
          },
        ),
        Text('Utiliser la localisation actuelle'),
      ],
    );
  }
  Widget _buildNbCameras() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombre de caméras',
        hintText: 'Entrez le nombre de caméras',
        prefixIcon: Icon(Icons.videocam),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre de caméras requis';
        }
        return null;
      },
      onSaved: (String? value) {
        _nbCameras = int.parse(value!);
      },
    );
  }

}
