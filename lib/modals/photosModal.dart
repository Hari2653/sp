// To parse this JSON data, do
//
//     final photosModal = photosModalFromJson(jsonString);

import 'dart:convert';

List<PhotosModal> photosModalFromJson(String str) => List<PhotosModal>.from(
    json.decode(str).map((x) => PhotosModal.fromJson(x)));

String photosModalToJson(List<PhotosModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosModal {
  PhotosModal({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  factory PhotosModal.fromJson(Map<String, dynamic> json) => PhotosModal(
        albumId: json["albumId"] == null ? null : json["albumId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        thumbnailUrl:
            json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId == null ? null : albumId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
      };
}
