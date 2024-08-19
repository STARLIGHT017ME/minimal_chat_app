import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chat_app/model/message.dart';

//method fetchs data from the firestore database

class Chatservice {
  //get instance of firestore
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection('Users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (docs) {
            // go through each individual user
            final user = docs.data();
            return user;
          },
        ).toList();
      },
    );
  }

  //send message to user
  Future<void> sendMessage(String recieverId, String message) async {
    print('Sending message: $message to $recieverId');

    //get current user info
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
      senderEmail: currentUserEmail,
      senderID: currentUserId,
      recieverID: recieverId,
      message: message,
      timestamp: timestamp,
    );
    //construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); //sort the ids(thiis ensure the chatroomID is the same for any two people)
    String chatRoomId = ids.join("_");
    //add new message to database
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message from user
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    print('Fetching messages between $userID and $otherUserID');

    //construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
