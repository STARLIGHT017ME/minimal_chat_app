import 'package:flutter/material.dart';
import 'package:minimal_chat_app/reusables/customdrawer.dart';
import 'package:minimal_chat_app/reusables/customusertile.dart';
import 'package:minimal_chat_app/screens/chatpage.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/services/chat_services/chat_service.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final Chatservice chatservice = Chatservice();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(child: Text("Home Page")),
      ),
      drawer: const Mydrawer(),
      body: builduserlist(),
    );
  }

  //build a list of users except the current logged in users
  Widget builduserlist() {
    return StreamBuilder(
      stream: chatservice.getUserStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading.........."));
        }
        return ListView(
          children: snapshot.data
              .map<Widget>(
                (userData) => buiduserlistitem(userData, context),
              )
              .toList(),
        );
      },
    );
  }

  //build individual list tile for user
  Widget buiduserlistitem(Map<String, dynamic> userData, BuildContext context) {
    //display all user except current user

    if (userData["email"] != authService.getcurrentuser()!.email) {
      return CustomUserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chatpage(
                recieverEmail: userData["email"],
                recieverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
