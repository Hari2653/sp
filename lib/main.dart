import 'package:flutter/material.dart';
import 'package:practicaltest1/screens/firstTask/firstTask.dart';
import 'package:practicaltest1/screens/home/homePage.dart';
import 'package:practicaltest1/screens/secondTask/secondtask.dart';
import 'package:practicaltest1/services/apiServices.dart';
import 'package:practicaltest1/services/itemServices.dart';
import 'package:practicaltest1/services/userServices.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ItemServices(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserServices(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
