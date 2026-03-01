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
        title: Text('Note App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: 10,
          itemBuilder: (context, index) {
          return NoteCard(
             
            title: 'Note Title ${index + 1}', 
            description: 'This is the description for note ${index+1}.',
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => FormScreen()),
            // );
            await noteController.addNote('New Note', 'This is a new note description');
            noteController.getNotes();
          },
          child: Icon(Icons.add),
        ),
    );
  }
}