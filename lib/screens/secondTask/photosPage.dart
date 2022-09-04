import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practicaltest1/services/userServices.dart';
import 'package:provider/provider.dart';

class PhotosPage extends StatefulWidget {
  PhotosPage({Key? key, required this.user}) : super(key: key);
  String user;

  @override
  State<PhotosPage> createState() => PhotosPageState();
}

class PhotosPageState extends State<PhotosPage> {
  @override
  void initState() {
    super.initState();
  }

  //getImageFrom gallary
  XFile? imageState;

  final ImagePicker _picker = ImagePicker();
  XFile? image = null;

  selectImage() async {
    // Pick an image
    image = await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServices>(builder: (context, userServies, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('${widget.user.toUpperCase()}\'s Photos '),
          ),
          drawer: const Drawer(),
          body: userServies.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userServies.photos?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.grey.shade100,
                                )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: userServies.photos?[index].url ==
                                              "FALSE"
                                          ? SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Image.file(File(
                                                  "${userServies.photos?[index].thumbnailUrl}")),
                                            )
                                          : Image.network(
                                              userServies.photos?[index]
                                                      .thumbnailUrl ??
                                                  '',
                                            ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        userServies.photos?[index].title ?? '',
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: -7,
                                right: -7,
                                child: IconButton(
                                    onPressed: () {
                                      //
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                title:
                                                    const Text('Delete User'),
                                                content: Text(
                                                  'Are you sure you want to delete this photo',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      userServies
                                                          .deletePhoto(index);
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Confirm'),
                                                  ),
                                                ]);
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 16,
                                      color: Colors.teal,
                                    )),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Add New Photo'),
            icon: const Icon(Icons.image),
            backgroundColor: Colors.green.shade400,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    userServies.email.clear();
                    userServies.name.clear();

                    return AlertDialog(
                      title: const Text('Add New Photo'),
                      content: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        // XFile?  imageState = userServies.image;

                        setState(() {
                          imageState = image;
                        });

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a valid name'
                                  : null,
                              controller: userServies.name,
                              decoration: const InputDecoration(
                                  hintText: 'Enter User Name'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                              minRadius: imageState?.path != null ? 80 : 40,
                              backgroundColor: Colors.grey.shade200,
                              child: imageState?.path != null
                                  ? Container(
                                      height: 120,
                                      width: 120,
                                      child: Image.file(File(imageState!.path)))
                                  : IconButton(
                                      iconSize: 30,
                                      onPressed: () async {
                                        image = await _picker.pickImage(
                                            source: ImageSource.gallery);
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.image)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Click on the image to add a new photo"),
                          ],
                        );
                      }),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              userServies.name.text.isEmpty
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Please Enter Name')))
                                  : userServies.addtoPhotos(imageState!.path,
                                      userServies.photos?[0].albumId);
                              Navigator.pop(context);
                            },
                            child: const Text('Add'))
                      ],
                    );
                  });
            },
          ));
    });
  }
}
