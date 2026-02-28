import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
                
                
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey,
                  ),
                  Text(
                    'Add Image',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              minLines: null,
              maxLines: null,
            ),
            ElevatedButton(
                onPressed: () {
                  // Action to save the note
                },
                child: Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}