import 'package:flutter/material.dart';
import 'package:socially/utils/constants/colors.dart';
import 'package:socially/widgets/main/reels/add_reels.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  // open bottonsheet
  void _showAddModel(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => AddReelSreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reels"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainOrangeColor,
        onPressed: () => _showAddModel(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
