import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String postId;
  final String userId;
  final String commentId;
  final DateTime timestamp;
  final String content;
  final String username;

  CommentModel({
    required this.postId,
    required this.userId,
    required this.commentId,
    required this.username,
    required this.timestamp,
    required this.content,
  });
  /*--------------------------------------------------------------------
  The fromdata factory constructor is used to create a CommentModel instance
  from a Documentdata retrieved from Firestore.
  */
  factory CommentModel.fromSnapshot(Map<String, dynamic> data) {
    return CommentModel(
      postId: data['postId'],
      userId: data['userId'],
      commentId: data['commentId'],
      username: data['username'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      content: data['content'] ?? '',
    );
  }
  /*---------------------------------------------
  Converts the CommentModel object to a map, 
  which can be used to save the CommentModel in Firestore.
  */
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'commentId': commentId,
      'username': username,
      'timestamp': Timestamp.fromDate(timestamp),
      'content': content,
    };
  }
}
