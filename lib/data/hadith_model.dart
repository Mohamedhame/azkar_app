class HadithModel {
  final int id;
  final String chapterTitle;
  final String body;

  HadithModel({
    required this.id,
    required this.chapterTitle,
    required this.body,
  });

  factory HadithModel.fromMap(Map<String, dynamic> map) {
    return HadithModel(
      id: map['id'],
      chapterTitle: map['chapterTitle'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapterTitle': chapterTitle,
      'body': body,
    };
  }
}
