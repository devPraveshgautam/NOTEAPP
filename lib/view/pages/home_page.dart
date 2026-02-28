import 'package:flutter/material.dart';
import 'package:note_app/view/pages/form_screen.dart';
import 'package:note_app/view/widget/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: 15,
          itemBuilder: (context, index) {
          return NoteCard(
            
            title: 'Note Title ${index + 1}', 
            description: 'This is the description for note ${index+1}.',
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
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