class NoteModel {
    NoteModel({
        required this.id,
        required this.title,
        required this.description,
    });

    final int? id;
    final String? title;
    final String? description;

    factory NoteModel.fromJson(Map<String, dynamic> json){ 
        return NoteModel(
            id: json["id"],
            title: json["title"],
            description: json["description"],
        );
    }

}
