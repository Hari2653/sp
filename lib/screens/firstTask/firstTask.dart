import 'package:flutter/material.dart';
import 'package:practicaltest1/services/itemServices.dart';
import 'package:provider/provider.dart';

class Firsttask extends StatefulWidget {
  const Firsttask({Key? key}) : super(key: key);

  @override
  State<Firsttask> createState() => _FirsttaskState();
}

class _FirsttaskState extends State<Firsttask> {
  @override
  void initState() {
    super.initState();
    var items = Provider.of<ItemServices>(context, listen: false);
    items.addItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemServices>(builder: (context, itemServies, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('First Task'),
        ),
        body: Column(children: itemServies.itemsList),
      );
    });
  }
}
