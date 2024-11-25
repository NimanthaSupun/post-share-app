import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/models/post_model.dart';
import 'package:socially/services/feed/feed_storage.dart';
import 'package:socially/utils/functions/mood.dart';

class FeedService {
  // collection references
  final CollectionReference _feedCollection =
      FirebaseFirestore.instance.collection("feeds");

//  save the post
  Future<void> savePost(Map<String, dynamic> postDetails) async {
    try {
      String? postUrl;
      // check if post here
      if (postDetails["postUrl"] != null && postDetails["postUrl"] is File) {
        postUrl = await FeedStorage().uploadImage(
          postImage: postDetails["postUrl"] as File,
          userId: postDetails["userId"] as String,
        );
      }

      // create psot
      final Post newPost = Post(
        postCaption: postDetails["postCaption"] as String? ?? "",
        mood: MoodExtension.fromString(postDetails["mood"] ?? 'happy'),
        userId: postDetails["userId"] as String? ?? "",
        username: postDetails["username"] as String? ?? "",
        likes: 0,
        postId: "",
        datePublished: DateTime.now(),
        postUrl: postUrl ?? "",
        profImage: postDetails["profImage"] as String? ?? "",
      );
      final DocumentReference docRef = await _feedCollection.add(
        newPost.toJson(),
      );

      await docRef.update(
        {"postId": docRef.id},
      );
      print("Post saved");
    } catch (e) {
      print("Error Saving psot: $e");
    }
  }

  // fetch the post
  Stream<List<Post>> getPostStream() {
    return _feedCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // method to like post
  Future<void> likePost({
    required String postId,
    required String userId,
  }) async {
    try {
      final DocumentReference postLikesRef =
          _feedCollection.doc(postId).collection("likes").doc(userId);

      await postLikesRef.set({"LikedAt": Timestamp.now()});

      // update like count
      final DocumentSnapshot postDoc = await _feedCollection.doc(postId).get();

      final Post post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

      final int newLikes = post.likes + 1;

      await _feedCollection.doc(postId).update({"likes": newLikes});
      print("Post Likes Successfully");
    } catch (e) {
      print("Error Like post $e");
    }
  }

  // method to unlike post
  Future<void> disLikePost({
    required String postId,
    required String userId,
  }) async {
    try {
      final DocumentReference postLikesRef =
          _feedCollection.doc(postId).collection("likes").doc(userId);

      await postLikesRef.delete();

      // update like count
      final DocumentSnapshot postDoc = await _feedCollection.doc(postId).get();

      final Post post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

      final int newLikes = post.likes - 1;

      await _feedCollection.doc(postId).update({"likes": newLikes});
      print("Post disLikes Successfully");
    } catch (e) {
      print("Error disLike post $e");
    }
  }

  // check if user like a post
  Future<bool> hasUserLikedPost(
      {required String postId, required String userId}) async {
    try {
      final DocumentReference postLikeRef =
          _feedCollection.doc(postId).collection("likes").doc(userId);

      final DocumentSnapshot doc = await postLikeRef.get();
      return doc.exists;
    } catch (e) {
      print("Error check if user like or not $e");
      return false;
    }
  }

  // delete a post
  Future<void> deletePost(
      {required String postId, required String postUrl}) async {
    try {
      // remove from cloud
      await FeedStorage().deleteImage(imageUrl: postUrl);

      // delete document
      await _feedCollection.doc(postId).delete();
      print("post is deleted");
    } catch (e) {
      print("Error deleting psot $e");
    }
  }

  // get all post from user
  Future<List<String>> getAllUserPostImages({required String userId}) async {
    try {
      final userPost = await _feedCollection
          .where("userId", isEqualTo: userId)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          return Post.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
      return userPost.map((post) => post.postUrl).toList();
    } catch (e) {
      print("Error fetching post: $e");
      return [];
    }
  }
}
