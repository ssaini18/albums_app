import 'package:equatable/equatable.dart';

class Album extends Equatable {
  const Album({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  Album copyWith({
    int? id,
    String? title,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json["id"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };

  @override
  List<Object?> get props => [
        id,
        title,
      ];
}
