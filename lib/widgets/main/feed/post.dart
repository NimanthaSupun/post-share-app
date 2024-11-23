import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socially/models/post_model.dart';
import 'package:socially/services/feed/feed_service.dart';
import 'package:socially/utils/constants/colors.dart';
import 'package:socially/utils/functions/function.dart';
import 'package:socially/utils/functions/mood.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback ondelete;
  final String currentUserId;
  const PostWidget({
    super.key,
    required this.post,
    required this.onEdit,
    required this.ondelete,
    required this.currentUserId,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;

  // check if user alreay like
  Future<void> _checkIfUserLiked() async {
    final bool hasLiked = await FeedService().hasUserLikedPost(
      postId: widget.post.postId,
      userId: widget.currentUserId,
    );

    setState(() {
      _isLiked = hasLiked;
    });
  }

  // method to like and dislike
  void _likeOrDisLikePost() async {
    try {
      if (_isLiked) {
        await FeedService().disLikePost(
          postId: widget.post.postId,
          userId: widget.currentUserId,
        );
        setState(() {
          _isLiked = false;
        });
        UtilFunctions().showSnackBarWdget(
          context,
          "Post unliked",
        );
      } else {
        await FeedService().likePost(
          postId: widget.post.postId,
          userId: widget.currentUserId,
        );
        setState(() {
          _isLiked = true;
        });
        UtilFunctions().showSnackBarWdget(
          context,
          "Post Liked",
        );
      }
    } catch (e) {
      print(e.toString());
      UtilFunctions().showSnackBarWdget(
        context,
        "fail to like or disLike",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfUserLiked();
  }

  @override
  Widget build(BuildContext context) {
    // format date
    final formatedDate =
        DateFormat("dd/MM/yyyy HH:mm").format(widget.post.datePublished);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: webBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      widget.post.profImage.isEmpty
                          ? "https://i.stack.imgur.com/l60Hf.png"
                          : widget.post.profImage,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.username,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatedDate,
                        style: TextStyle(
                          color: mainWhiteColor.withOpacity(0.4),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: mainPurpleColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    "Feeling ${widget.post.mood.name} ${widget.post.mood.emoji}",
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.post.postCaption,
                style: TextStyle(
                  color: mainWhiteColor.withOpacity(0.6),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              const SizedBox(
                height: 8,
              ),
              widget.post.postUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.post.postUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://www.affordableluxurytravel.co.uk/blog/wp-content/uploads/2023/03/Sigiriya-Sri-Lanka-min-edited.jpg",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: _likeOrDisLikePost,
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? mainOrangeColor : mainWhiteColor,
                        ),
                      ),
                      Text(
                        "${widget.post.likes} Likes",
                      ),
                    ],
                  ),
                  if (widget.post.userId == widget.currentUserId)
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                children: [
                                  _buildDialogOptions(
                                    context: context,
                                    icon: Icons.edit,
                                    text: "Edit",
                                    onTab: () {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      color: mainWhiteColor.withOpacity(0.5),
                                    ),
                                  ),
                                  _buildDialogOptions(
                                    context: context,
                                    icon: Icons.delete,
                                    text: "Delete",
                                    onTab: () {
                                      widget.ondelete();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogOptions(
      {required BuildContext context,
      required IconData icon,
      required String text,
      required VoidCallback onTab}) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: mainWhiteColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
