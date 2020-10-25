import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manistra/src/helpers/auth_helper.dart';
import 'package:manistra/src/screens/welcome.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: null,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthHelper.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: WelcomeScreen(),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: AuthHelper.getUsername(),
        builder: (context, snapshot) => Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                snapshot.hasData ? snapshot.data : '',
                style: TextStyle(fontSize: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
