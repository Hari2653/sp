import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practicaltest1/modals/albumModal.dart';
import 'package:practicaltest1/modals/photosModal.dart';
import 'package:practicaltest1/modals/userModal.dart';
import 'package:http/http.dart' as http;

class APIServices {
  String baseUrl = "https://jsonplaceholder.typicode.com";
  dynamic headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<UserModal>?> fetchUsers() async {
    List<UserModal>? result;

    try {
      final response =
          await http.get(Uri.parse("$baseUrl/users"), headers: headers);
      if (response.statusCode == 200) {
        print("Success fetching users");
        var json = response.body;
        result = userModalFromJson(json);
        return result;
      } else {
        print("error in fetching users");
      }
    } catch (e) {
      print(e.toString());
      print("error in fetching users");
    }
    return result;
  }

  Future<List<AlbumModal>?> fetchAlbums(id) async {
    List<AlbumModal>? result;

    try {
      final response = await http.get(Uri.parse("$baseUrl/albums?userId=$id"),
          headers: headers);
      if (response.statusCode == 200) {
        print("Success fetching users");
        var json = response.body;
        result = albumModalFromJson(json);
        return result;
      } else {
        print("error in fetching albums");
      }
    } catch (e) {
      print(e.toString());
      print("error in fetching albums");
    }
    return result;
  }

  Future<List<PhotosModal>?> fetchAlbumPhotos(id) async {
    List<PhotosModal>? result;

    try {
      final response = await http.get(Uri.parse("$baseUrl/albums/$id/photos"),
          headers: headers);
      if (response.statusCode == 200) {
        print("Success fetching photos");
        var json = response.body;
        result = photosModalFromJson(json);

        return result;
      } else {
        print("error in fetching photos");
      }
    } catch (e) {
      print(e.toString());
      print("error in fetching photos");
    }
    return result;
  }
}
