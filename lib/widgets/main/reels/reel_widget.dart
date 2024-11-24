import 'package:flutter/material.dart';
import 'package:socially/models/reel_model.dart';
import 'package:socially/utils/constants/colors.dart';
import 'package:socially/widgets/main/reels/video_player.dart';

class ReelWidget extends StatelessWidget {
  final Reel reel;
  const ReelWidget({
    super.key,
    required this.reel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mobileBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    reel.profileImage.isEmpty
                        ? "https://i.stack.imgur.com/l60Hf.png"
                        : reel.profileImage,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  reel.userName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              reel.caption,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayerWidget(
                videoUrl: reel.vedioUrl,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.thumb_up,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
