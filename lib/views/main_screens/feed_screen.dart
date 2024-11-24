import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/post_model.dart';
import 'package:socially/services/feed/feed_service.dart';
import 'package:socially/utils/functions/function.dart';
import 'package:socially/widgets/main/feed/post.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  // delete post
  Future<void> _deletePost(
      {required String postId,
      required String postUrl,
      required BuildContext context}) async {
    try {
      await FeedService().deletePost(
        postId: postId,
        postUrl: postUrl,
      );
      UtilFunctions().showSnackBarWdget(
        context,
        "post deleted",
      );
    } catch (e) {
      print("Error deleting post $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FeedService().getPostStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Fail to fetch post"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No post available"),
            );
          }
          final List<Post> posts = snapshot.data!;
          return ListView.builder(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostWidget(
                    post: post,
                    onEdit: () {},
                    ondelete: () {
                      _deletePost(
                        context: context,
                        postId: post.postId,
                        postUrl: post.postUrl,
                      );
                    },
                    currentUserId: FirebaseAuth.instance.currentUser!.uid,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
