import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/utils/functions/mood.dart';
import 'package:socially/widgets/reusable/custom_button.dart';
import 'package:socially/widgets/reusable/custom_input.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _captionController = TextEditingController();
  File? _imageFile;
  Mood _selectedMood = Mood.happy;
  bool _isUoloding = false;

  // image picker
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pikedImage = await picker.pickImage(source: source);
    if (pikedImage != null) {
      setState(() {
        _imageFile = File(pikedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableInput(
                  controller: _captionController,
                  labelText: "Caption",
                  icon: Icons.text_fields,
                  obscreText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter a Caption";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButton<Mood>(
                  value: _selectedMood,
                  items: Mood.values.map((Mood mood) {
                    return DropdownMenuItem(
                      value: mood,
                      child: Text("${mood.name} ${mood.emoji}"),
                    );
                  }).toList(),
                  onChanged: (Mood? newMood) {
                    setState(() {
                      _selectedMood = newMood ?? _selectedMood;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: kIsWeb
                            ? Image.network(_imageFile!.path)
                            : Image.file(_imageFile!),
                      )
                    : const Text(
                        "No image selected",
                      ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableButton(
                      text: "Use Camera",
                      width: MediaQuery.of(context).size.width * 0.43,
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    ReusableButton(
                      text: "Use gallery",
                      width: MediaQuery.of(context).size.width * 0.43,
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ],
                ),
                ReusableButton(
                  text: kIsWeb ? "Not supported yet":"Create Post",
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
