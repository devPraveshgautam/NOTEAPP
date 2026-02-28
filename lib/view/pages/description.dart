import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Image
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              'assets/no_image.png',
              fit: BoxFit.contain,
            ),
          ),
          // Title
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Description
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'editFab',
            onPressed: () {},
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'deleteFab',
            onPressed: () {},
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}