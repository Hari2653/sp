import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practicaltest1/modals/albumModal.dart';
import 'package:practicaltest1/modals/photosModal.dart';
import 'package:practicaltest1/modals/userModal.dart';
import 'package:practicaltest1/services/apiServices.dart';

class UserServices extends ChangeNotifier {
  bool isLoading = false;

  List<UserModal>? users;
  List<AlbumModal>? albums;
  List<PhotosModal>? photos;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  setUserDetails(userName, userEmail) {
    name.text = userName;
    email.text = userEmail;
    notifyListeners();
  }

  setAlbumDetails(userName) {
    name.text = userName;

    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? image = null;

  selectImage() async {
    // Pick an image
    image = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  deleteUser(index) {
    users?.removeAt(index);
    notifyListeners();
  }

  deleteAlbum(index) {
    albums?.removeAt(index);
    notifyListeners();
  }

  deletePhoto(index) {
    photos?.removeAt(index);
    notifyListeners();
  }

  addUser() {
    var lastIndex = users?.length;
    users?.add(UserModal(id: lastIndex, name: name.text, email: email.text));
    notifyListeners();
  }

  addAlbum() {
    var lastIndex = albums?.length;
    albums?.add(AlbumModal(id: lastIndex, title: name.text));
    notifyListeners();
  }

  addtoPhotos(path, albmId) {
    var lastIndex = photos?.length;
    photos?.add(PhotosModal(
        title: name.text,
        url: "FALSE",
        thumbnailUrl: path,
        id: lastIndex,
        albumId: albmId));
    notifyListeners();
    print(photos);
  }

  updateValue(index) {
    print(users?[index].email = email.text);
    print(users?[index].name = name.text);
    notifyListeners();
  }

  updateValueAlbum(index) {
    print(albums?[index].title = name.text);

    notifyListeners();
  }

  Future<void> getUsers() async {
    isLoading = true;
    notifyListeners();

    users = await APIServices().fetchUsers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAlbums(id) async {
    isLoading = true;
    notifyListeners();

    albums = await APIServices().fetchAlbums(id);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAlbumPhotos(id) async {
    isLoading = true;
    notifyListeners();

    photos = await APIServices().fetchAlbumPhotos(id);

    isLoading = false;
    notifyListeners();
  }
}
