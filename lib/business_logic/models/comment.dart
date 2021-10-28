class Comment {
  Comment({
    required this.id,
    required this.email,
    required this.text,
    required this.episodeId,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      email: map['email'] as String,
      text: map['text'] as String,
      episodeId: map['episodeId'] as String,
    );
  }

  final String id;
  final String email;
  final String text;
  final String episodeId;
}
