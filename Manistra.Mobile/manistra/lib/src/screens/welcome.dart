import 'package:flutter/material.dart';
import 'package:manistra/src/screens/home.dart';
import 'package:manistra/src/screens/login.dart';
import 'package:manistra/src/screens/signup.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/manistra_logo.png', height: 300),
            Text('manistra', style: TextStyle(fontSize: 50)),
            Container(padding: EdgeInsets.all(20)),
            logInButton(context, size),
            signUpButton(context, size),
            continueButton(context)
          ],
        ),
      ),
    );
  }

  Widget continueButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: Home(),
        ),
      ),
      child: Text(
        'Continue without an account',
        style: TextStyle(color: Colors.amber[100]),
      ),
    );
  }

  Widget signUpButton(BuildContext context, Size size) {
    return Container(
      width: size.width * 0.7,
      child: RaisedButton(
        color: Colors.amberAccent,
        onPressed: () async => await Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: SignupScreen(),
          ),
        ),
        child: Text('Sign up'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }

  Widget logInButton(BuildContext context, Size size) {
    return Container(
      width: size.width * 0.7,
      child: RaisedButton(
        color: Colors.amberAccent,
        onPressed: () async => await Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: LoginScreen(),
          ),
        ),
        child: Text('Log In'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}
