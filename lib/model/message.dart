import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderEmail,
    required this.senderID,
    required this.recieverID,
    required this.message,
    required this.timestamp,
  });
  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'senderID': senderID,
      'recieverID': recieverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}