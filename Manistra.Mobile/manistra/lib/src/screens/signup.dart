import 'package:flutter/material.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:manistra/src/widgets/social_media_buttons.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  final _repo = Repository();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(padding: EdgeInsets.all(10)),
                usernameField(size),
                passwordField(size),
                confirmPasswordField(size),
                signUpButton(size),
                orText(),
                SocialMediaButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameField(Size size) {
    return Container(
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: _username,
        validator: (value) {
          if (value.length < 5) {
            return 'The username is too short';
          }
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          border: InputBorder.none,
          hintText: 'username',
        ),
      ),
    );
  }

  Widget passwordField(Size size) {
    return Container(
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: true,
        controller: _password,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          border: InputBorder.none,
          hintText: 'password',
        ),
      ),
    );
  }

  Widget confirmPasswordField(Size size) {
    return Container(
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: true,
        controller: _confirmPassword,
        validator: (value) {
          if (_password.text != value) {
            return 'The passwords must match';
          }
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          border: InputBorder.none,
          hintText: 'confirm password',
        ),
      ),
    );
  }

  Widget signUpButton(Size size) {
    return Container(
      width: size.width * 0.7,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.amberAccent,
        onPressed: () => _formKey.currentState.validate()
            ? submitForm(_username.text, _password.text)
            : null,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'SIGN UP',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget orText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Text(
        'OR',
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  void submitForm(username, password) {
    final response = _repo.signUp(username, password);
  }
}
