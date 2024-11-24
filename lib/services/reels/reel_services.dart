import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/models/reel_model.dart';

class ReelServices {
  // coolection references
  final CollectionReference _reelsCollection =
      FirebaseFirestore.instance.collection("reels");

  // todo: store reels

  Future<void> saveReel(Map<String, dynamic> reelDetails) async {
    try {
      final Reel newReel = Reel(
        reelId: "",
        caption: reelDetails['caption'],
        vedioUrl: reelDetails['vedioUrl'],
        userId: reelDetails['userId'],
        userName: reelDetails['userName'],
        profileImage: reelDetails['profileImage'],
        dataPublished: DateTime.now(),
      );

      final DocumentReference ref =
          await _reelsCollection.add(newReel.toJson());
      await ref.update({"reelId": ref.id});
      print("Reel Stored");
      
    } catch (e) {
      print(e.toString());
    }
  }
}
