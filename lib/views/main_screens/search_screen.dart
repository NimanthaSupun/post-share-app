import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/services/users/user_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<UserModel> _users = [];
  List<UserModel> _filterdusers = [];

  Future<void> _fetchAllUsers() async {
    try {
      final List<UserModel> users = await UserService().getAllUsers();
      setState(() {
        _users = users;
        _filterdusers = users;
      });
    } catch (e) {
      print("Error Fetching users: $e");
    }
  }

  // search users
  void _searchUsers(String query) {
    setState(() {
      _filterdusers = _users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // navigation
  void _navigateTOSingleUserProfile(UserModel user) {
    GoRouter.of(context).push(
      "/user-profile",
      extra: user,
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: Divider.createBorderSide(context)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: Divider.createBorderSide(context),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: _searchUsers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filterdusers.length,
              itemBuilder: (context, index) {
                final UserModel user = _filterdusers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user.imageUrl.isNotEmpty
                        ? NetworkImage(user.imageUrl)
                        : const AssetImage("assets/logo.png") as ImageProvider,
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.jobTitle),
                  onTap: () => _navigateTOSingleUserProfile(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
