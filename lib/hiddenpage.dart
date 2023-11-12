import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_bharat_clone/Home_Page.dart';
import 'package:todo_list_bharat_clone/hide_tile.dart';
import 'package:todo_list_bharat_clone/hive_data_pass.dart';

class HiddenPage extends StatefulWidget {
  const HiddenPage({
    super.key,
  });

  @override
  State<HiddenPage> createState() => _HiddenPageState();
}

class _HiddenPageState extends State<HiddenPage> {
  final _mybox = Hive.box('mybox');
  tododb db = tododb();
  int selectedmenu = 1;
  void unhide(int index) {
    setState(() {
      db.b[index][2] = !db.b[index][2];
      db.a.add(db.b[index]);
      db.b.removeAt(index);
      db.updatedatabase();
    });
  }

  void onitemTapped(int item) {
    setState(() {
      selectedmenu = item;
    });
  }

  List found = [];

  @override
  void initState() {
    // TODO: implement initState
    // if (_mybox.get("todolist") == null) {
    //   db.createinitialdata();
    // } else {
    //   // db.loaddata();
    // }
    // db.loadpw();
    if (_mybox.get("hidelist") == null) {
      db.initiallist();
    }
    db.loadpassword();
    db.loadpw();
    db.updatedatabase();
    // db.updatedatabase();
    found = db.b;
    super.initState();
  }

  void _runfilter(String enteredkeyword) {
    List result;
    if (enteredkeyword.isEmpty) {
      result = db.b;
    } else {
      result = db.b
          .where((user) =>
              user[0].toLowerCase().contains(enteredkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      found = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("hiddenpage");
    for (int i = 0; i < db.b.length; i++) {
      print(db.b[i]);
    }
    print("empty");
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('T O D O')),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _runfilter(value),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('S E A R C H'),
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, mainAxisSpacing: 1),
                itemCount: found.length,
                itemBuilder: (context, index) {
                  return hide_tile(
                    text: found[index][0],
                    unhide: (context) => unhide(index),
                    index: index,
                  );
                }),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            child: Text('M E N U ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text(
              'H O M E',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            selected: selectedmenu == 0,
            onTap: () {
              onitemTapped(0);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text(
              'H I D E',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            selected: selectedmenu == 1,
            onTap: () {
              onitemTapped(1);
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}
