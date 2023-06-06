import 'package:get/get.dart';
import '../models/post_model.dart';
import '../firestore_service.dart';

class PostController extends GetxController {
  RxList<PostModel> posts = <PostModel>[].obs;

  //RxList<int> counts = <int>[].obs;

  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Future<void> addPost(String title, String content, String uid, String uname,
      String type) async {
    await _firestoreService.addPost(title, content, uid, uname, type);
    // Additional actions after adding the post
  }

  // Board Screen
  Future<void> getPosts() async {
    try {
      final snapshot = await _firestoreService.getPosts();

      final List<PostModel> fetchedPosts = snapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc.data()))
          .toList();

      // Assign the fetched posts to the posts list
      posts.assignAll(fetchedPosts);
    } catch (e) {
      // Handle error
      print('[getPosts] Error fetching posts: $e');
    }
  }

  //Board Screen
  Future<void> getMorePosts(PostModel post) async {
    try {
      final snapshot = await _firestoreService.getMorePosts(post);
      final List<PostModel> fetchedPosts = snapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc.data()))
          .toList();
      // final count =
      //     await _firestoreService.getCommentCountByPostId(post.postId);

      // Assign the fetched posts to the posts list
      posts.addAll(fetchedPosts);
    } catch (e) {
      // Handle error
      print('[getMorePosts] Error fetching more posts: $e');
    }
  }

  Future<void> incrementViewCountByPostId(String postId) async {
    try {
      await _firestoreService.incrementViewCount(postId);
    } catch (e) {
      print(e);
    }
  }

  // Future<void> getCommentCounts(String postId) async {
  //   try {
  //     final snapshot = await _firestoreService.getCommentCountByPostId(postId);
  //     counts.add(snapshot);
  //   } catch (e) {
  //     print('[getCommentCounts] Error fetching comment numbers: $e');
  //   }
  // }

  Future<void> addReport(String postId, String type) async {
    await _firestoreService.sendReport(postId, type);
    // Additional actions after adding the post
  }
}
