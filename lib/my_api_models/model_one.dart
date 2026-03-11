import 'dart:convert';

class Apimodelone {
  final int userId;
  final int id;
  final String title;
  final String body;
  Apimodelone({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Apimodelone copyWith({int? userId, int? id, String? title, String? body}) {
    return Apimodelone(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Apimodelone.fromMap(Map<String, dynamic> map) {
    return Apimodelone(
      userId: map['userId'].toInt() as int,
      id: map['id'].toInt() as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Apimodelone.fromJson(String source) =>
      Apimodelone.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Apimodelone(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(covariant Apimodelone other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
  }
}
