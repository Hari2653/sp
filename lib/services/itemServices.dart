import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practicaltest1/modals/itemsModal.dart';

class ItemServices extends ChangeNotifier {
  ItemsModal? itemData;
  List<Widget> itemsList = <Widget>[];

  dynamic data = {
    "items": [
      {
        "title": "Item 1",
        "items": [
          {
            "title": "Item 1.1",
            "items": [
              {"title": "1.1.1", "items": []},
              {"title": "1.1.2", "items": []}
            ]
          },
          {
            "title": "Item 1.2",
            "items": [
              {"title": "1.2.1", "items": []}
            ]
          }
        ]
      },
      {
        "title": "Item 2",
        "items": [
          {"title": "2.1", "items": []},
          {"title": "2.2", "items": []}
        ]
      },
      {
        "title": "Item 3",
        "items": [
          {"title": "3.1", "items": []},
          {
            "title": "3.2",
            "items": [
              {"title": "3.2.1", "items": []}
            ]
          }
        ]
      }
    ]
  };

  void addItems() {
    itemData = ItemsModal.fromJson(data);
    addExpantionTile(itemData?.items);
    notifyListeners();
  }

  void addExpantionTile(list) {
    List<Widget> childiwidgets = <Widget>[];

    list?.forEach((element) {
      List<Widget> subChildiwidgets = <Widget>[];
      element.items?.forEach((child) {
        child.items?.forEach((subchild) {
          subChildiwidgets.add(ExpansionTile(
            title: Text("Item ${subchild.title!}"),
            children: const [],
          ));
        });

        childiwidgets.add(ExpansionTile(
          trailing: subChildiwidgets.isEmpty
              ? const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.transparent,
                )
              : null,
          childrenPadding: const EdgeInsets.only(left: 20),
          title: Text(
              "${child.title.toString().contains("Item") ? child.title : "Item ${child.title}"}"),
          children: subChildiwidgets,
        ));
        subChildiwidgets = <Widget>[];
      });
      itemsList.add(ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 20),
        trailing: childiwidgets.isEmpty
            ? const Icon(
                Icons.arrow_drop_down,
                color: Colors.transparent,
              )
            : null,
        title: Text(
          "${element.title.toString().contains("Item") ? element.title : "Item ${element.title}"}",
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: childiwidgets,
      ));
      childiwidgets = <Widget>[];
    });
    notifyListeners();
  }
}
