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
      Get.snackbar("Error", e.toString(), duration: Duration(seconds: 1));
      return [];
    }
    // return data;
  }

  Future<void> addNote(String title, String description, {String? imagePath}) async {
    try {
      await dbhelper.insertData(title, description, imagePath: imagePath);
    } catch (e) {
      Get.snackbar("Error", e.toString(), duration: Duration(seconds: 1));
    }
  }

  Future<int> updateNote(int id, String title, String description, {String? imagePath}) async {
    try {
      return await dbhelper.updateData(id, title, description, imagePath: imagePath);
    } catch (e) {
      Get.snackbar("Error", e.toString(), duration: Duration(seconds: 1));
      return 0;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await dbhelper.deleteData(id);
      Get.snackbar(" Deleted Successfully", "", duration: Duration(seconds: 1));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
