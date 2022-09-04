import 'package:flutter/material.dart';
import 'package:practicaltest1/screens/secondTask/photosPage.dart';
import 'package:practicaltest1/services/userServices.dart';
import 'package:provider/provider.dart';

class AlbumsList extends StatefulWidget {
  AlbumsList({Key? key, required this.user}) : super(key: key);
  String user;

  @override
  State<AlbumsList> createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {
  @override
  void initState() {
    super.initState();
  }

  updateAlbum(index, userServies) {
    userServies.updateValueAlbum(
      index,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServices>(builder: (context, userServies, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('${widget.user}\'s Albums '),
          ),
          drawer: const Drawer(),
          body: userServies.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userServies.albums?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              userServies.getAlbumPhotos(
                                  userServies.albums?[index].id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotosPage(
                                            user: userServies
                                                    .albums?[index].title ??
                                                '',
                                          )));
                            },
                            child: ListTile(
                              title: Text(userServies.albums?[index].title
                                      .toString()
                                      .toUpperCase() ??
                                  ''),
                              subtitle: Text(
                                  userServies.albums?[index].id.toString() ??
                                      ''),
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.photo_album,
                                ),
                              ),
                              trailing: Wrap(
                                spacing: 3,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (() {
                                      userServies.setAlbumDetails(
                                          userServies.albums?[index].title);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Edit Album'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    validator: (value) => value!
                                                            .isEmpty
                                                        ? 'Please enter a valid name'
                                                        : null,
                                                    controller:
                                                        userServies.name,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Enter User Name'),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      userServies
                                                              .name.text.isEmpty
                                                          ? ScaffoldMessenger
                                                                  .of(context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Please Enter Name')))
                                                          : updateAlbum(index,
                                                              userServies);
                                                    },
                                                    child: const Text('Add'))
                                              ],
                                            );
                                          });
                                    }),
                                    icon: const Icon(Icons.edit, size: 15),
                                  ),
                                  IconButton(
                                    onPressed: (() {
                                      // Delete User Dialogue
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                title:
                                                    const Text('Delete Album'),
                                                content: Text(
                                                  'Are you sure you want to delete ${userServies.albums?[index].title}?',
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
                                                          .deleteAlbum(index);
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Confirm'),
                                                  ),
                                                ]);
                                          });
                                    }),
                                    icon: const Icon(Icons.delete, size: 15),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Add New Album'),
            icon: const Icon(Icons.photo_album),
            backgroundColor: Colors.green.shade400,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    userServies.email.clear();
                    userServies.name.clear();
                    return AlertDialog(
                      title: const Text('Add New Album'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a valid name'
                                : null,
                            controller: userServies.name,
                            decoration: const InputDecoration(
                                hintText: 'Enter Album Name'),
                          ),
                        ],
                      ),
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
                                  : addNewUser(context, userServies);
                            },
                            child: const Text('Add'))
                      ],
                    );
                  });
            },
          ));
    });
  }

  addNewUser(context, userServies) {
    userServies.addAlbum();
    userServies.email.clear();
    userServies.name.clear();
    Navigator.pop(context);
  }
}
