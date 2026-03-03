import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/pages/form_screen.dart';

class DescriptionScreen extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String? imagePath;

  const DescriptionScreen({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    var noteController = Get.find<NoteController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            SizedBox(
              height: 200,
              width: double.infinity,
              child: imagePath == null
                  ? Image.asset(
                      'assets/no_image.png',
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                    ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'editFab',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormScreen(
                    id: id,
                    initialTitle: title,
                    initialContent: description,
                    initialImagePath: imagePath,
                  ),
                ),
              ).then((changed) {
                // only act if the form actually saved something
                if (changed == true) {
                  noteController.getNotes();
                  Get.back(); // close description
                }
              });
            },

            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'deleteFab',
            onPressed: () {
              noteController.deleteNote(id);
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}