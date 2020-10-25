import 'package:flutter/material.dart';
import 'package:manistra/src/helpers/auth_helper.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:manistra/src/screens/home.dart';
import 'package:manistra/src/widgets/social_media_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _repo = Repository();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String errorText = '';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(padding: EdgeInsets.all(10)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorText,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                usernameField(size),
                passwordField(size),
                logInButton(size),
                orText(),
                SocialMediaButtons(),
                FlatButton(
                  onPressed: () => {},
                  child: Text('Need an account? Create one',
                      style: TextStyle(color: Colors.black38)),
                ),
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
          if (value.isEmpty) {
            return 'Please enter a username';
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

  Widget logInButton(Size size) {
    return Container(
      width: size.width * 0.7,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.amberAccent,
        onPressed: () => _formKey.currentState.validate()
            ? submitForm(_username.text, _password.text, context)
            : null,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'LOG IN',
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

  void submitForm(username, password, BuildContext context) async {
    final response = await _repo.logIn(username, password);

    if (response.success) {
      AuthHelper.setToken(response.token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Home(),
          ),
        ),
      );
    } else {
      setState(() {
        errorText = response.error;
      });
    }
  }
}
