import 'package:flutter/material.dart';
import 'package:note_app/view/pages/description.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key,required this.title,required this.description, required this.id});
  final String title;
  final String description;
  final int id;
 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DescriptionScreen()),
        );
      },
      child: Container(
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    
                    Positioned(
                      
                      child: Image.asset(
                      'assets/no_image.png',
                      fit: BoxFit.contain,
                                        ),
                    ),
                    Positioned(
                      top: 3,
                      left: 5,
                      child: Text(id.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      )
                      
                      ),
                  ],
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
    );
  }
}