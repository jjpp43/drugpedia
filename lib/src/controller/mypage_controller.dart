import 'package:get/get.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../firestore_service.dart';

class MyPageController extends GetxController {
  RxList<PostModel> myPosts = <PostModel>[].obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;

  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Future<void> getPostsByUserId() async {
    try {
      final snapshot = await _firestoreService.getPostsByUserId();
      final List<PostModel> fetchedPosts = snapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc.data()))
          .toList();

      // Assign the fetched posts to the posts list
      myPosts.assignAll(fetchedPosts);
    } catch (e) {
      // Handle error
      print('[getPostsByUserId] Error fetching posts: $e');
    }
  }

  Future<void> getMorePostsByUserId(PostModel lastPost) async {
    try {
      final snapshot = await _firestoreService.getMorePostsByUserId(lastPost);
      final List<PostModel> fetchedPosts = snapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc.data()))
          .toList();

      // Assign the fetched posts to the posts list
      myPosts.addAll(fetchedPosts);
    } catch (e) {
      // Handle error
      print('[getMorePostsByUserId] Error fetching posts: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestoreService.deletePost(postId);
      await getPostsByUserId();
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  // Comment
  Future<void> getCommentsByUserId() async {
    try {
      final snapshot = await _firestoreService.getCommentsByUserId();
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
  Future<void> getMoreCommentsByUserId(CommentModel lastComment) async {
    try {
      final snapshot =
          await _firestoreService.getMoreCommentsByUserId(lastComment);
      final List<CommentModel> fetchedComments = snapshot.docs
          .map((doc) => CommentModel.fromSnapshot(doc.data()))
          .toList();

      // Assign the fetched posts to the posts list
      comments.addAll(fetchedComments);
    } catch (e) {
      // Handle error
      print('[getComments] Error fetching comments: $e');
    }
  }

  //Delete comment
  Future<void> deleteComment(String commentId) async {
    try {
      await _firestoreService.deleteComment(commentId);
      await getPostsByUserId();
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}
