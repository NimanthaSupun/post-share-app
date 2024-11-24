import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/services/reels/reel_services.dart';
import 'package:socially/services/reels/reel_storage.dart';
import 'package:socially/services/users/user_service.dart';
import 'package:socially/utils/functions/function.dart';
import 'package:socially/widgets/reusable/custom_button.dart';

class AddReelSreen extends StatefulWidget {
  const AddReelSreen({super.key});

  @override
  State<AddReelSreen> createState() => _AddReelSreenState();
}

class _AddReelSreenState extends State<AddReelSreen> {
  final TextEditingController _captionController = TextEditingController();

  File? _videoFile;
  bool _isUpLoding = false;

  // pick a vedio
  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedVideoFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideoFile != null) {
      setState(() {
        _videoFile = File(pickedVideoFile.path);
      });
    }
  }

  // upload video
  void _submitReel() async {
    if (_videoFile != null && _captionController.text.isNotEmpty) {
      try {
        setState(() {
          _isUpLoding = true;
        });
        // do not allow web user create reels
        if (kIsWeb) {
          return;
        }

        // upload video storage
        final String vidoUrl = await ReelStorage().uploadVideo(
          videoFile: _videoFile!,
          userId: FirebaseAuth.instance.currentUser!.uid,
        );

        // get user info
        final UserModel? userData = await UserService()
            .getUserById(FirebaseAuth.instance.currentUser!.uid);

        // create reel details
        final reelDetails = {
          'caption': _captionController.text,
          'vedioUrl': vidoUrl,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'userName': userData?.name,
          'profileImage': userData?.imageUrl,
        };

        await ReelServices().saveReel(reelDetails);
        // colos pannel
        UtilFunctions().showSnackBarWdget(
          context,
          "Reel Uploded",
        );
        Navigator.of(context).pop();
      } catch (e) {
        print("fail to upload reels: $e");
        UtilFunctions().showSnackBarWdget(
          context,
          "Fail to upload reels",
        );
      } finally {
        setState(() {
          _isUpLoding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  labelText: "Caption",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: Divider.createBorderSide(context),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: Divider.createBorderSide(context),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _videoFile != null
                  ? Text("Video file path: ${_videoFile!.path}")
                  : const Text("No video seleted"),
              const SizedBox(
                height: 5,
              ),
              ReusableButton(
                text: "Select video",
                width: double.infinity,
                onPressed: _pickVideo,
              ),
              const SizedBox(
                height: 10,
              ),
              ReusableButton(
                text: kIsWeb
                    ? "Web not Supported"
                    : _isUpLoding
                        ? "Uploding..."
                        : "Upload Reel",
                width: double.infinity,
                onPressed: _submitReel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
