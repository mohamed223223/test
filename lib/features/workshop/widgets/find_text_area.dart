// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workshop_app/languageFolder/Localization/localization_constant.dart';

class FindTextArea extends StatefulWidget {
  const FindTextArea({super.key});

  @override
  State<FindTextArea> createState() => _FindTextAreaState();
}

class _FindTextAreaState extends State<FindTextArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: RichText(
            text: TextSpan(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
              TextSpan(
                  text: getTranslated(context, "find"),
                  style: TextStyle(fontSize: 30)),
              TextSpan(
                  text: " " + getTranslated(context, "our_workshops"),
                  style: TextStyle(color: Colors.white60, fontSize: 30))
            ])),
      ),
    );
  }
}
