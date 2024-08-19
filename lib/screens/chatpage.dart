import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/reusables/chatbubble.dart';
import 'package:minimal_chat_app/reusables/customTF.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/services/chat_services/chat_service.dart';

class Chatpage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;

  Chatpage({super.key, required this.recieverEmail, required this.recieverID});

  final TextEditingController messagecontroller = TextEditingController();

  final Chatservice chatservice = Chatservice();
  final AuthService authService = AuthService();

  //send message method
  void sendMessage() async {
    if (messagecontroller.text.isNotEmpty) {
      await chatservice.sendMessage(recieverID, messagecontroller.text);
      messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          builduserinput()
        ],
      ),
    );
  }

  Widget buildMessageList() {
    String senderID = authService.getcurrentuser()!.uid;
    return StreamBuilder(
      stream: chatservice.getMessages(recieverID, senderID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading.........."));
        }

        // Ensuring that the map function returns a list of Widgets
        List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((doc) {
          return buildMessageItem(doc);
        }).toList();

        return ListView(children: messageWidgets);
      },
    );
  }

  //build message item
  //responsible for converting raw message data into a visually structured and user-friendly chat message within the UI
  Widget buildMessageItem(DocumentSnapshot docs) {
    Map<String, dynamic> data = docs.data() as Map<String, dynamic>;

    //check if it is the current user
    bool iscurrrentuser = data['senderID'] == authService.getcurrentuser()!.uid;
    //align message to the right if sender is the current sender , otherwise left
    var alignment =
        iscurrrentuser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            iscurrrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Chatbubble(message: data["message"], iscurrentuser: iscurrrentuser)
        ],
      ),
    );
  }

  //build message input text field
  Widget builduserinput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Customtf(
                controller: messagecontroller,
                hinttext: "Type a message",
                keyboardType: TextInputType.text,
                obsecuretext: false),
          ),
          IconButton(
              onPressed: sendMessage, icon: const Icon(Icons.send_outlined))
        ],
      ),
    );
  }
}
