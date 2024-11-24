import 'package:cloud_firestore/cloud_firestore.dart';

class Reel {
  final String reelId;
  final String caption;
  final String vedioUrl;
  final String userId;
  final String userName;
  final String profileImage;
  final DateTime dataPublished;

  Reel({
    required this.reelId,
    required this.caption,
    required this.vedioUrl,
    required this.userId,
    required this.userName,
    required this.profileImage,
    required this.dataPublished,
  });

  // convert dart
  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      reelId: json['reelId'] ?? '',
      caption: json['caption'] ?? '',
      vedioUrl: json['vedioUrl'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      dataPublished: (json['dataPublished'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reelId':reelId,
      'caption':caption,
      'vedioUrl':vedioUrl,
      'userId':userId,
      'userName':userName,
      'profileImage':profileImage,
      'dataPublished':dataPublished,
    };
  }
}
