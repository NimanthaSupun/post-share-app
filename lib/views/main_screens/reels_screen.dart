import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/reel_model.dart';
import 'package:socially/services/reels/reel_services.dart';
import 'package:socially/utils/constants/colors.dart';
import 'package:socially/widgets/main/reels/add_reels.dart';
import 'package:socially/widgets/main/reels/reel_widget.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: ReelServices().getReel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No reels available "),
            );
          }
          final List<Reel> reels = snapshot.data!.docs
              .map((doc) => Reel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
          return ListView.builder(
            itemCount: reels.length,
            itemBuilder: (context, index) {
              final Reel reel = reels[index];
              return ReelWidget(
                reel: reel,
              );
            },
          );
        },
      ),
    );
  }
}
