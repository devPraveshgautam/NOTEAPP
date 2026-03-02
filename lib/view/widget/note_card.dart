import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key,required this.title,required this.description, required this.id});
  final String title;
  final String description;
  final int id;

  @override
  Widget build(BuildContext context) {
    var noteController = Get.find<NoteController>();
    return InkWell(
      onTap: () {
      },
      child: Stack(
        children: [
          Container(
          height: 200,
          width: double.infinity,
          // padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/no_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Border
              Container(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              // Title
               Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Description
                      Flexible(
                        child: Text(
                          description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 35,
          right: 0,
          child: IconButton(onPressed: () {
            noteController.deleteNote(id);
          }, icon: Icon(Icons.delete))
           )
        ],
        
      ),
    );
  }
}