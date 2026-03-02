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
      appBar: AppBar(title: Text('Note App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => noteController.isGettingNotes.value? Center(child: CircularProgressIndicator()) :
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: noteController.noteModelList.length,
            itemBuilder: (context, index) {
              var note = noteController.noteModelList[index];
              return NoteCard(
                title: note.title ?? 'No Title',
                description:
                    note.description ??
                    'No Description',
                    id: note.id ?? 0,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
