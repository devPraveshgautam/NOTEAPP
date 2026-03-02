import 'package:get/get.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/service/note_service.dart';

class NoteController extends GetxController {
  var noteService = NoteService();
  var noteModelList = <NoteModel>[].obs;
  RxBool isGettingNotes = false.obs;

  void getNotes() async{
    try{
      isGettingNotes(true);
      var notes = await noteService.getData();
      noteModelList.value = notes;
    } catch(e) {
      Get.snackbar("Error", e.toString(), duration: Duration(seconds: 1));
    } finally {
      isGettingNotes(false);
    }
  }

  void addNote(String title, String description) async {
    await noteService.addNote(title, description);
    getNotes();
  }
  void deleteNote(int id) async {
    await noteService.deleteNote(id);
    getNotes();
  }
  onInit() {
    super.onInit();
    getNotes();
  }
}
