import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/pages/form_screen.dart';
import 'package:note_app/view/widget/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Get.put(NoteController());
  }

  @override
  Widget build(BuildContext context) {
    var noteController = Get.find<NoteController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (noteController.isGettingNotes.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final notes = noteController.noteModelList;
        final width = MediaQuery.of(context).size.width;
        
        if (notes.isEmpty) {
          return const Center(
            child: Text(
              'No notes yet\nTap + to create one',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        
        if (width > 600) {
          // tablets / landscape: grid layout
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                var note = notes[index];
                return NoteCard(
                  title: note.title ?? 'No Title',
                  description: note.description ?? 'No Description',
                  displayIndex: index + 1,
                  noteId: note.id ?? 0,
                  imagePath: note.imagePath,
                );
              },
            ),
          );
        }
        
        // phone / narrow screens: list
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            var note = notes[index];
            return NoteCard(
              title: note.title ?? 'No Title',
              description: note.description ?? 'No Description',
              displayIndex: index + 1,
              noteId: note.id ?? 0,
              imagePath: note.imagePath,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          ).then((changed) {
            if (changed == true) {
              noteController.getNotes();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
