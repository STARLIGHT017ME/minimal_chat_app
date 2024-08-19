import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/screens/homepage.dart';
import 'package:minimal_chat_app/screens/loginorreg.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //user is login
          if (snapshot.hasData) {
            return Homepage();
          }
          //user is not login
          else {
            return const Loginorreg();
          }
        },
      ),
    );
  }
}
