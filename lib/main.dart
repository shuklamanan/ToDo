import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_bharat_clone/Home_Page.dart';
import 'package:todo_list_bharat_clone/hive_data_pass.dart';
import 'package:todo_list_bharat_clone/set_pw.dart';

void main() async {
  await Hive.initFlutter();
  var _mybox = await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _mybox = Hive.box('mybox');
  tododb db = tododb();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: (_mybox.get("pw").toString().trim() == "")
          ? setpassword()
          : HomePage(),
    );
  }
}
