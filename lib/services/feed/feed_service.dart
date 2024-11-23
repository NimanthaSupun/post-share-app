
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
      if (postDetails["postUrl"] != null &&
          postDetails["postUrl"] is File) {
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
}
