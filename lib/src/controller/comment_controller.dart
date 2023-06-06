import 'package:get/get.dart';
import '../models/comment_model.dart';
import '../firestore_service.dart';

class CommentController extends GetxController {
  RxList<CommentModel> comments = <CommentModel>[].obs;

  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Future<void> addComment(
      String postId, String content, String uid, String uname) async {
    await _firestoreService.addComment(postId, content);
  }

  // Comment
  Future<void> getComments(String postId) async {
    try {
      final snapshot = await _firestoreService.getCommentsByPostId(postId);
      final List<CommentModel> fetchedComments = snapshot.docs
          .map((doc) => CommentModel.fromSnapshot(doc.data()))
          .toList();

      // Assign the fetched posts to the posts list
      comments.assignAll(fetchedComments);
    } catch (e) {
      // Handle error
      print('[getComments] Error fetching comments: $e');
    }
  }

  // Comment
  Future<void> getMoreComments(CommentModel comment) async {
    try {
      final snapshot = await _firestoreService.getMoreCommentsByPostId(comment);
      final List<CommentModel> fetchedComments = snapshot.docs
          .map((doc) => CommentModel.fromSnapshot(doc.data()))
          .toList();

      // Assign the fetched posts to the posts list
      comments.addAll(fetchedComments);
    } catch (e) {
      // Handle error
      print('[getMoreComments] Error fetching comments: $e');
    }
  }
}
