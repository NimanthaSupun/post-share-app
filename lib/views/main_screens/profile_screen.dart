import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/services/auth/auth_service.dart';
import 'package:socially/widgets/reusable/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // todo: sign out
  void _signOut(BuildContext context) async {
    await AuthService().signOut();
    GoRouter.of(context).go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReusableButton(
          text: "SignOut",
          width: double.infinity,
          onPressed: () => _signOut(context),
        ),
      ),
    );
  }
}
