class NoteModel {
  int? id;
  String? title;
  String? description;
  String? imagePath; // local file path to the picture

  NoteModel({this.id, this.title, this.description, this.imagePath});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imagePath = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (imagePath != null) data['image'] = imagePath;
    return data;
  }
}
