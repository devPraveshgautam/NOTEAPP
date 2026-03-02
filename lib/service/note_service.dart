import 'package:get/get.dart';
import 'package:note_app/helper/data_helper.dart';
import 'package:note_app/model/note_model.dart';

class NoteService {
  var dbhelper = DatabaseHelper();
  Future<List<NoteModel>> getData() async {
    try {
      var data = await dbhelper.getData();
      return data.map((note) {
        return NoteModel.fromJson(note as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return [];
    }
    // return data;
  }

  Future<void> addNote(String title, String description) async {
    try {
      await dbhelper.insertData(title, description);
    } catch (e) {
      print('Error adding note: $e');
    }
  }
}
