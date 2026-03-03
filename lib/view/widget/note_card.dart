import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/pages/description.dart';
import 'package:note_app/view/pages/form_screen.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.description,
    required this.displayIndex,
    required this.noteId,
    this.imagePath,
  });

  final String title;
  final String description;
  final int displayIndex; // sequential number shown on UI
  final int noteId; // actual DB id for operations
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    var noteController = Get.find<NoteController>();

    return Dismissible(
      key: Key(noteId.toString()),
      onDismissed: (direction) {
        noteController.deleteNote(noteId);
      },
      background: Container(
        alignment: Alignment.center,
        child: const Text(
          'Delete',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.center,
        child: const Text(
          'Delete',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 600),
          child: InkWell(
            onTap: () {
              // open detail/edit screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DescriptionScreen(
                    id: noteId,
                    title: title,
                    description: description,
                    imagePath: imagePath,
                  ),
                ),
              );
            },
            onLongPress: () {
              // quick edit
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormScreen(
                    id: noteId,
                    initialTitle: title,
                    initialContent: description,
                    initialImagePath: imagePath,
                  ),
                ),
              ).then((changed) {
                if (changed == true) {
                  Get.find<NoteController>().getNotes();
                }
              });
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section - only show if image exists
                  if (imagePath != null)
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  // Title & description section
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}