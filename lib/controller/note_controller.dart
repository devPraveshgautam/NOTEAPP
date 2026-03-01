import 'package:get/get.dart';
import 'package:note_app/service/note_service.dart';

class NoteController extends GetxController {
  var noteService = NoteService();
  
  addNote(String title, String description) {
     noteService.addNote(title, description);
  }
  getNotes() {
     noteService.getData();
  }
}
