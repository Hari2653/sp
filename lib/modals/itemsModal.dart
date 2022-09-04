// To parse this JSON data, do
//
//     final itemsModal = itemsModalFromJson(jsonString);

import 'dart:convert';

ItemsModal itemsModalFromJson(String str) =>
    ItemsModal.fromJson(json.decode(str));

String itemsModalToJson(ItemsModal data) => json.encode(data.toJson());

class ItemsModal {
  ItemsModal({
    this.items,
  });

  List<Item>? items;

  factory ItemsModal.fromJson(Map<String, dynamic> json) => ItemsModal(
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.title,
    this.items,
  });

  String? title;
  List<Item>? items;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"] == null ? null : json["title"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
