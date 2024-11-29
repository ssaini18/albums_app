import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({
    required this.id,
    required this.albumId,
    required this.url,
  });

  final int id;
  final int albumId;
  final String url;

  Photo copyWith({
    int? id,
    int? albumId,
    String? url,
  }) {
    return Photo(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      url: url ?? this.url,
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json["id"],
      albumId: json["albumId"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "albumId": albumId,
        "url": url,
      };

  @override
  List<Object?> get props => [
        id,
        albumId,
        url,
      ];
}
