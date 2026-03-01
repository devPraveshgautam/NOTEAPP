import 'package:note_app/helper/data_helper.dart';

class NoteService {
  var dbhelper = DatabaseHelper();
  Future<void> getData() async {
    try {
      var data = await dbhelper.getData();
      print(data);
    } catch (e) {
      print('Error fetching data: $e');
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
