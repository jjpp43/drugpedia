import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String userId;
  final String username;
  final DateTime timestamp;
  final String title;
  final String content;
  final String type;
  int commentCounts;
  int likeCounts;
  int viewCounts;

  PostModel({
    required this.postId,
    required this.userId,
    required this.username,
    required this.timestamp,
    required this.title,
    required this.content,
    required this.type,
    required this.likeCounts,
    required this.commentCounts,
    required this.viewCounts,
  });
  /*--------------------------------------------------------------------
  The fromSnapshot factory constructor is used to create a PostModel instance
  from a DocumentSnapshot retrieved from Firestore.
  */
  factory PostModel.fromSnapshot(Map<String, dynamic> data) {
    return PostModel(
      postId: data['postId'],
      userId: data['userId'],
      username: data['username'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      title: data['title'],
      content: data['content'],
      likeCounts: data['likeCounts'] ?? 0,
      commentCounts: data['commentCounts'] ?? 0,
      viewCounts: data['viewCounts'] ?? 0,
      type: data['type'] ?? 'etc',
    );
  }
  /*---------------------------------------------
  Converts the PostModel object to a map, 
  which can be used to save the PostModel in Firestore.
  */
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'username': username,
      'timestamp': Timestamp.fromDate(timestamp),
      'title': title,
      'content': content,
      'likeCounts': likeCounts,
      'commentCounts': commentCounts,
      'viewCounts': viewCounts,
      'type': type,
    };
  }
}
