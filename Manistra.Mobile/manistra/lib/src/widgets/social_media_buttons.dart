import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            color: Colors.amberAccent,
            onPressed: () => {},
            child: FaIcon(FontAwesomeIcons.facebook),
          ),
          RaisedButton(
            color: Colors.amberAccent,
            onPressed: () => {},
            child: FaIcon(FontAwesomeIcons.google),
          ),
        ],
      ),
    );
  }
}
