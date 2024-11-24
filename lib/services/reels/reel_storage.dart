import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ReelStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // upload to storage
  Future<String> uploadVideo(
      {required File videoFile, required String userId}) async {
    try {
      // unique file name
      String fileName = "${DateTime.now().microsecondsSinceEpoch}.mp4";

      // create ref
      final Reference ref =
          _firebaseStorage.ref().child("reel").child("$userId/$fileName");

      // upload vide
      await ref.putFile(videoFile);

      // get video url
      final String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Error uploding video $e");
      return "";
    }
  }

  // delete video
  Future<void> deleteVideo({required String videoUrl}) async {
    try {
      final Reference ref = _firebaseStorage.refFromURL(videoUrl);
      await ref.delete();
    } catch (e) {
      print("Error deleting video");
    }
  }
}
