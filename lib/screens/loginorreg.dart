import 'package:flutter/material.dart';
import 'package:minimal_chat_app/screens/loginpage.dart';
import 'package:minimal_chat_app/screens/registerpage.dart';

class Loginorreg extends StatefulWidget {
  const Loginorreg({super.key});

  @override
  State<Loginorreg> createState() => _LoginorregState();
}

class _LoginorregState extends State<Loginorreg> {
  //intially show the login page right
  bool showloginpage = true;

  //toggle btwn the login and the home page

  void togglepage() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: showloginpage
            ? Loginpage(ontap: togglepage)
            : Registerpage(
                ontap: togglepage,
              ));
  }
}
