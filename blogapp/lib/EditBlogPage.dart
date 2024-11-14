import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditBlogPage extends StatefulWidget {
  final String initialTitle;
  final String initialContent;
  final String initialImageUrl;

  const EditBlogPage({
    required this.initialTitle,
    required this.initialContent,
    required this.initialImageUrl,
    super.key,
  });

  @override
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      final title = _titleController.text;
      final content = _contentController.text;
      final image = _image;

      // You can now use the title, content, and image to update the blog post
      print('Title: $title');
      print('Content: $content');
      print('Image: ${image?.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_image != null)
                Image.file(
                  File(_image!.path),
                  height: 200,
                  fit: BoxFit.cover,
                )
              else
                Image.network(
                  widget.initialImageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              IconButton(
                onPressed: _pickImage,
                icon: const Icon(Icons.add),
                iconSize: 30, // Size of the icon
                color: Colors.black, // Icon color
                padding: const EdgeInsets.all(16.0), // Padding around the icon
                // You can wrap the IconButton in a Container for more styling if needed
                // You can also add a tooltip
                tooltip: 'Upload Image',
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50), // Button size
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}