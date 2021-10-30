import 'dart:convert';

class Show {
  Show({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.likeCount,
  });

  factory Show.fromMap(Map<String, dynamic> map) {
    return Show(
      id: map['_id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      likeCount: map['likesCount'] as int,
    );
  }

  final String id;
  final String title;
  final String imageUrl;
  final int likeCount;

  Show copyWith({
    String? id,
    String? title,
    String? imageUrl,
    int? likeCount,
  }) {
    return Show(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'likeCount': likeCount,
    };
  }

  String toJson() => json.encode(toMap());
}
