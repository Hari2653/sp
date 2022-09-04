// To parse this JSON data, do
//
//     final albumModal = albumModalFromJson(jsonString);

import 'dart:convert';

List<AlbumModal> albumModalFromJson(String str) =>
    List<AlbumModal>.from(json.decode(str).map((x) => AlbumModal.fromJson(x)));

String albumModalToJson(List<AlbumModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumModal {
  AlbumModal({
    this.userId,
    this.id,
    this.title,
  });

  int? userId;
  int? id;
  String? title;

  factory AlbumModal.fromJson(Map<String, dynamic> json) => AlbumModal(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
      };
}
