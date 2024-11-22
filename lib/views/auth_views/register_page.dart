import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/services/users/user_service.dart';
import 'package:socially/services/users/user_storage.dart';
import 'package:socially/utils/constants/colors.dart';
import 'package:socially/utils/functions/function.dart';
import 'package:socially/widgets/reusable/custom_button.dart';
import 'package:socially/widgets/reusable/custom_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  File? _imageFile;

  // todo: pick image
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  // Sign up with email and password
  Future<void> _createUser(BuildContext context) async {
    try {
      //store the user image in storage and get the download url
      if (_imageFile != null) {
        final imageUrl = await UserProfileStorageService().uploadImage(
          profileImage: _imageFile!,
          userEmail: _emailController.text,
        );
        _imageUrlController.text = imageUrl;
      }

      //save user to firestore
      UserService().saveUser(
        UserModel(
          userId: "",
          name: _nameController.text,
          email: _emailController.text,
          jobTitle: _jobTitleController.text,
          imageUrl: _imageUrlController.text,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          password: _passwordController.text,
          followers: 0,
        ),
      );

      //show snackbar
      if (context.mounted) {
        UtilFunctions().showSnackBar(
          context,
          "User Create Successfully",
        );
      }
      GoRouter.of(context).go('/main-screen');
    } catch (e) {
      print('Error signing up with email and password: $e');

      //show snackbar
       if (context.mounted) {
        UtilFunctions().showSnackBar(
          context,
          "Error signing up with email and password: $e",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Image(
                image: AssetImage(
                  "assets/logo.png",
                ),
                height: 70,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          _imageFile != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundColor: mainPurpleColor,
                                  backgroundImage: FileImage(_imageFile!),
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundColor: mainPurpleColor,
                                  backgroundImage: NetworkImage(
                                    "https://i.stack.imgur.com/l60Hf.png",
                                  ),
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: () async {
                                _pickImage(ImageSource.gallery);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ReusableInput(
                      controller: _nameController,
                      labelText: "Name",
                      icon: Icons.person,
                      obscreText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ReusableInput(
                      controller: _emailController,
                      labelText: "Email",
                      icon: Icons.email,
                      obscreText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ReusableInput(
                      controller: _jobTitleController,
                      labelText: 'Job Title',
                      icon: Icons.work,
                      obscreText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your job title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ReusableInput(
                      controller: _passwordController,
                      labelText: 'Password',
                      icon: Icons.lock,
                      obscreText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ReusableInput(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      icon: Icons.lock,
                      obscreText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ReusableButton(
                      text: "Sign Up",
                      width: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await _createUser(context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go("/login");
                      },
                      child: const Text(
                        'Already have an account? Log in',
                        style: TextStyle(
                          color: mainWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
