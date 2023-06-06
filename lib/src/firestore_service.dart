// Firebase
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Model
import 'models/comment_model.dart';
import 'models/post_model.dart';
// Controller
import '../src/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  //Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Firebase Crashlytics instance for logging errors
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  final uuid = const Uuid();

  // -------------------------[Post Controller]---------------------------- //
  // Get initial posts
  Future<QuerySnapshot<Map<String, dynamic>>> getPosts() async {
    return _firestore
        .collection('posts')
        .limit(10)
        .orderBy('timestamp', descending: true)
        .get();
  }

  // Post Controller
  // Get 10 mores posts
  Future<QuerySnapshot<Map<String, dynamic>>> getMorePosts(
      PostModel lastPost) async {
    return _firestore
        .collection('posts')
        .limit(10)
        .orderBy('timestamp', descending: true)
        .startAfter([lastPost.timestamp]).get();
  }

  Future<void> incrementViewCount(String postId) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({'viewCounts': FieldValue.increment(1)});
    } catch (e) {
      await _crashlytics.recordError(e, null,
          reason:
              'Error while incrementing viewCount in post: $postId \n-- error : $e');
    }
  }

  // Add post to database
  Future<void> addPost(String title, String content, String userId,
      String username, String type) async {
    final postId = uuid.v4();
    try {
      var user = Get.find<AuthController>().user;
      await _firestore.collection('posts').doc(postId).set({
        'postId': postId,
        'userId': user!.uid,
        'username': user.displayName,
        'title': title,
        'content': content,
        'timestamp': DateTime.now(),
        'type': type == '' ? '기타' : type,
        'commentCounts': 0,
        'viewCounts': 0,
      });
    } catch (e) {
      await _crashlytics.recordError(e, null,
          reason: 'Error while adding post: $postId \n-- error : $e');
    }
  }

  // Post controller
  // Get the number of comments of each post
  Future<int> getCommentCountByPostId(String postId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .get();

      return snapshot.size; // Return the number of documents in the snapshot
    } catch (e) {
      await _crashlytics.recordError(e, null,
          reason:
              'Error while fetching commentCount on post: $postId \n-- error : $e');
      return 0; // Return a default value or handle the error appropriately
    }
  }

  // -------------------------[MyPage Controller]---------------------------- //
  // MyPageController
  // Get initial posts with a specific userId
  Future<QuerySnapshot<Map<String, dynamic>>> getPostsByUserId() async {
    var user = Get.find<AuthController>().user;
    return _firestore
        .collection('posts')
        .limit(10)
        .where('userId', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .get();
  }

  // MyPageController
  // Get 10 more posts with a specific userId
  Future<QuerySnapshot<Map<String, dynamic>>> getMorePostsByUserId(
      PostModel lastPost) async {
    var user = Get.find<AuthController>().user;
    return _firestore
        .collection('posts')
        .limit(10)
        .where('userId', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .startAfter([lastPost.timestamp]).get();
  }

  // MyPage controller
  // Delete post of current user
  Future<void> deletePost(String postId) async {
    try {
      final postRef = _firestore.collection('posts').doc(postId);
      await postRef.delete();
    } catch (e) {
      await _crashlytics.recordError(e, null,
          reason: 'Error while deleting post: $postId \n-- error : $e');
    }
  }

  // MyPage controller
  // Delete comment of current user
  Future<void> deleteComment(String commentId) async {
    try {
      final postRef = _firestore.collection('comments').doc(commentId);
      await postRef.delete();
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }

  // MyPage Controller
  // Get initial comments of current user
  Future<QuerySnapshot<Map<String, dynamic>>> getCommentsByUserId() async {
    var user = Get.find<AuthController>().user;
    return _firestore
        .collection('comments')
        .limit(10)
        .where('userId', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .get();
  }

  // MyPage Controller
  // Get 10 more comments of current user
  Future<QuerySnapshot<Map<String, dynamic>>> getMoreCommentsByUserId(
      CommentModel lastComment) async {
    var user = Get.find<AuthController>().user;
    return _firestore
        .collection('comments')
        .limit(10)
        .where('userId', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .startAfter([lastComment.timestamp]).get();
  }

  // Like button
  // Future<void> addLike(String postId) async {
  //   try {
  //     var user = Get.find<AuthController>().user;
  //     await _firestore
  //         .collection('posts')
  //         .doc(postId)
  //         .update({'likeCount': FieldValue.increment(1)});
  //   } catch (e) {
  //     // Handle error
  //     print('Error adding post: $e');
  //   }
  // }

  // Future<void> subtractLike(String postId) async {
  //   try {
  //     var user = Get.find<AuthController>().user;
  //     await _firestore
  //         .collection('posts')
  //         .doc(postId)
  //         .update({'likeCount': FieldValue.increment(-1)});
  //   } catch (e) {
  //     // Handle error
  //     print('Error adding post: $e');
  //   }
  // }

  // -------------------------[Comment Controller]---------------------------- //

  // Comment Controller
  // Add comment to database
  Future<void> addComment(String postId, String content) async {
    try {
      var user = Get.find<AuthController>().user;
      var commentId = uuid.v1();
      await _firestore.collection('comments').doc(commentId).set({
        'postId': postId,
        'commentId': commentId,
        'userId': user!.uid,
        'username': user.displayName,
        'content': content,
        'timestamp': DateTime.now(),
      });

      // //Increment count in a post
      await _firestore.collection('posts').doc(postId).update({
        'commentCounts': FieldValue.increment(1),
      });
      // final snapshot = await postRef.get();
      // final commentCount = snapshot.data()?['commentCount'] ?? 0;
    } catch (e) {
      await _crashlytics.recordError(e, null,
          reason:
              'Error while adding commment on post: $postId \n-- error : $e');
    }
  }

  // Comment Controller
  // Get initial comments
  Future<QuerySnapshot<Map<String, dynamic>>> getCommentsByPostId(
      String postId) async {
    return _firestore
        .collection('comments')
        .limit(10)
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .get();
  }

  // Comment Controller
  // Get 10 more comments
  Future<QuerySnapshot<Map<String, dynamic>>> getMoreCommentsByPostId(
      CommentModel lastComment) async {
    return _firestore
        .collection('comments')
        .limit(10)
        .where('postId', isEqualTo: lastComment.postId)
        .orderBy('timestamp', descending: true)
        .startAfter([lastComment.timestamp]).get();
  }

  // Report Controller
  // Send report of a specific post
  // - Where
  // - Who
  // - When
  // - Why
  Future<void> sendReport(String postId, String type) async {
    try {
      var user = Get.find<AuthController>().user;
      await _firestore.collection('reports').add(
        {
          'postId': postId,
          'userId': user!.uid,
          'timestamp': DateTime.now(),
          'type': type,
        },
      );
    } catch (e) {
      // Handle error
      await _crashlytics.recordError(e, null,
          reason: 'Error while reporting post: $postId \n-- error : $e');
    }
  }
}
