import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FeedStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // upload in image
  Future<String> uploadImage(
      {required File postImage, required String userId}) async {
    //  reference
    final Reference ref = _firebaseStorage.ref().child("feed-images").child(
          "$userId/${DateTime.now()}",
        );
    try {
      // store image
      final UploadTask task = ref.putFile(
        postImage,
        SettableMetadata(
          contentType: "image/jpeg",
        ),
      );

      TaskSnapshot snapshot = await task;
      final String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  // remove post
  Future<void> deleteImage({required String imageUrl}) async {
    try {
      await _firebaseStorage.refFromURL(imageUrl).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
