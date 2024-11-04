import 'package:burgan_api/pages/home.dart';
import 'package:burgan_api/login.dart/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = TextEditingController();
  final firstNameTextEditController = TextEditingController();
  final lastNameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  final confirmPasswordTextEditController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _errorMessage = '';

  void processError(final FirebaseAuthException error) {
    setState(() {
      _errorMessage = error.message ?? "An error occurred";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0190D3), // Light blue text for title
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$_errorMessage',
                  style: TextStyle(fontSize: 14.0, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                'Email',
                emailTextEditController,
                _emailFocus,
                _firstNameFocus,
                TextInputType.emailAddress,
                'Please enter a valid email.',
                false,
              ),
              SizedBox(height: 12),
              _buildTextField(
                'First Name',
                firstNameTextEditController,
                _firstNameFocus,
                _lastNameFocus,
                TextInputType.text,
                'Please enter your first name.',
                false,
              ),
              SizedBox(height: 12),
              _buildTextField(
                'Last Name',
                lastNameTextEditController,
                _lastNameFocus,
                _passwordFocus,
                TextInputType.text,
                'Please enter your last name.',
                false,
              ),
              SizedBox(height: 12),
              _buildTextField(
                'Password',
                passwordTextEditController,
                _passwordFocus,
                _confirmPasswordFocus,
                TextInputType.text,
                'Password must be longer than 8 characters.',
                true,
              ),
              SizedBox(height: 12),
              _buildTextField(
                'Confirm Password',
                confirmPasswordTextEditController,
                _confirmPasswordFocus,
                null,
                TextInputType.text,
                'Passwords do not match.',
                true,
              ),
              SizedBox(height: 24),
              _buildSignUpButton(),
              _buildCancelButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText,
    TextEditingController controller,
    FocusNode currentFocus,
    FocusNode? nextFocus,
    TextInputType keyboardType,
    String validationMessage,
    bool obscureText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          if (hintText == 'Confirm Password' &&
              value != passwordTextEditController.text) {
            return 'Passwords do not match.';
          }
          return null;
        },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        autofocus: false,
        focusNode: currentFocus,
        textInputAction:
            nextFocus != null ? TextInputAction.next : TextInputAction.done,
        onFieldSubmitted: (term) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Color(0xFF0190D3),
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _firebaseAuth
                .createUserWithEmailAndPassword(
                    email: emailTextEditController.text,
                    password: passwordTextEditController.text)
                .then((onValue) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(onValue.user?.uid)
                  .set({
                'firstName': firstNameTextEditController.text,
                'lastName': lastNameTextEditController.text,
              }).then((userInfoValue) {
                GoRouter.of(context).push('/home');
              });
            }).catchError((onError) {
              processError(onError);
            });
          }
        },
        child: Text('Sign Up'.toUpperCase(),
            style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Padding(
      padding: EdgeInsets.zero,
      child: TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          GoRouter.of(context).push('/');
        },
      ),
    );
  }
}
