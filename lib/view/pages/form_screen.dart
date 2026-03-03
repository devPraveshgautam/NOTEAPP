import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/controller/note_controller.dart';

class FormScreen extends StatefulWidget {
  final int? id;
  final String? initialTitle;
  final String? initialContent;
  final String? initialImagePath;

  const FormScreen({
    super.key,
    this.id,
    this.initialTitle,
    this.initialContent,
    this.initialImagePath,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  bool _isContentFilled = false;

  @override
  void initState() {
    super.initState();
    // populate fields if editing
    if (widget.initialTitle != null) titleController.text = widget.initialTitle!;
    if (widget.initialContent != null) contentController.text = widget.initialContent!;
    _imagePath = widget.initialImagePath;
    
    // Check initial content state
    _isContentFilled = contentController.text.trim().isNotEmpty;
    
    // Listen to content changes
    contentController.addListener(() {
      setState(() {
        _isContentFilled = contentController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imagePath = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var noteController = Get.find<NoteController>();
    final bool isEditing = widget.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Add Note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            if (_imagePath != null)
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.file(
                    File(_imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Center(
                child: ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Add Image'),
                ),
              ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              minLines: null,
              maxLines: null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isContentFilled ? () async {
                final title = titleController.text.trim();
                final content = contentController.text.trim();
                if (isEditing) {
                  await noteController.updateNote(widget.id!, title, content,
                      imagePath: _imagePath);
                } else {
                  await noteController.addNote(title, content,
                      imagePath: _imagePath);
                }
                if (mounted) {
                  Navigator.pop(context, true); // Indicate that a change was made
                }
                
              } : null,
              child: Text(isEditing ? 'Update' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
