import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _errorMessage = '';

  void onChange() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    emailController.addListener(onChange);
    passwordController.addListener(onChange);

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset('assets/img/burgan.jpg'),
      ),
    );

    final errorMessage = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        _errorMessage,
        style: TextStyle(fontSize: 14.0, color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );

    final email = TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true || !value!.contains('@')) {
          return 'Please enter a valid email.';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(node);
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xFF0190D3),
          padding: EdgeInsets.all(16),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            signIn(emailController.text, passwordController.text).then((uid) {
              // On successful login, use GoRouter to navigate
              GoRouter.of(context).push('/home');
            }).catchError((error) {
              processError(error);
            });
          }
        },
        child:
            Text('Log In', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Color(0xFF0669A5), fontSize: 16),
      ),
      onPressed: () {
        if (emailController.text.isNotEmpty) {
          resetPassword(emailController.text);
        } else {
          setState(() {
            _errorMessage = 'Please enter your email to reset the password.';
          });
        }
      },
    );

    final registerButton = Padding(
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Color.fromARGB(255, 142, 142, 142),
          padding: EdgeInsets.all(16),
        ),
        onPressed: () {
          GoRouter.of(context).push('/register');
        },
        child: Text('Register',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );

    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                errorMessage,
                email,
                SizedBox(height: 12.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                registerButton,
                forgotLabel
              ],
            ),
          ),
        ));
  }

  Future<String> signIn(final String email, final String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user!.uid;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      setState(() {
        _errorMessage = 'Password reset email sent. Check your inbox.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to send reset email. Try again.';
      });
    }
  }

  void processError(final FirebaseAuthException error) {
    if (error.code == "user-not-found") {
      setState(() {
        _errorMessage = "Unable to find user. Please register.";
      });
    } else if (error.code == "wrong-password") {
      setState(() {
        _errorMessage = "Incorrect password.";
      });
    } else {
      setState(() {
        _errorMessage =
            "There was an error logging in. Please try again later.";
      });
    }
  }
}
