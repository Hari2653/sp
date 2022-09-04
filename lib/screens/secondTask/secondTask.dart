import 'package:flutter/material.dart';
import 'package:practicaltest1/screens/secondTask/albumPage.dart';
import 'package:practicaltest1/services/userServices.dart';
import 'package:provider/provider.dart';

class SecondTask extends StatefulWidget {
  SecondTask({Key? key}) : super(key: key);

  @override
  State<SecondTask> createState() => _SecondTaskState();
}

class _SecondTaskState extends State<SecondTask> {
  @override
  void initState() {
    super.initState();
    var users = Provider.of<UserServices>(context, listen: false);
    users.getUsers();
  }

  updateUser(index, userServies) {
    userServies.updateValue(
      index,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServices>(builder: (context, userServies, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Users List'),
          ),
          drawer: const Drawer(),
          body: userServies.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userServies.users?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              userServies
                                  .getAlbums(userServies.users?[index].id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlbumsList(
                                            user: userServies
                                                    .users?[index].name ??
                                                '',
                                          )));
                            },
                            child: ListTile(
                              title: Text(
                                userServies.users?[index].name ?? '',
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                userServies.users?[index].email ?? '',
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              trailing: Wrap(
                                spacing: 3,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (() {
                                      userServies.setUserDetails(
                                          userServies.users?[index].name,
                                          userServies.users?[index].email);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Edit User'),
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
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please Enter Email';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        userServies.email,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Enter User Email Address'),
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
                                                      userServies.email.text
                                                              .isEmpty
                                                          ? ScaffoldMessenger
                                                                  .of(context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Please Enter Email')))
                                                          : userServies.name
                                                                  .text.isEmpty
                                                              ? ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                          content: Text(
                                                                              'Please Enter Name')))
                                                              : updateUser(
                                                                  index,
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
                                                    const Text('Delete User'),
                                                content: Text(
                                                  'Are you sure you want to delete ${userServies.users?[index].name}',
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
                                                          .deleteUser(index);
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
            label: const Text('Add New User'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.green.shade400,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    userServies.email.clear();
                    userServies.name.clear();
                    return AlertDialog(
                      title: const Text('Add New User'),
                      content: Column(
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            controller: userServies.email,
                            decoration: const InputDecoration(
                                hintText: 'Enter User Email Address'),
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
                              userServies.email.text.isEmpty
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Please Enter Email')))
                                  : userServies.name.text.isEmpty
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Please Enter Name')))
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
    Navigator.pop(context);
    userServies.addUser();
    userServies.email.clear();
    userServies.name.clear();
  }
}
