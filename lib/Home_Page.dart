import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_bharat_clone/hive_data_pass.dart';
import 'package:todo_list_bharat_clone/passw_match.dart';
import 'package:todo_list_bharat_clone/reset_pass.dart';
import 'package:todo_list_bharat_clone/tiling.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  int selectedmenu = 0;
  List found = [];
  tododb db = tododb();
  TextEditingController _addtask = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void onitemTapped(int item) {
    setState(() {
      selectedmenu = item;
    });
  }

  void deletetask(int index) {
    setState(() {
      db.a.removeAt(index);
      db.updatedatabase();
    });
  }

  void _runfilter(String enteredkeyword) {
    List result = [];
    if (enteredkeyword.isEmpty) {
      result = db.a;
    } else {
      result = db.a
          .where((user) =>
              user[0].toLowerCase().contains(enteredkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      found = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (_mybox.get("publist") == null) {
      db.initiallist();
    } else {
      db.loadpw();
      db.loadpassword();
    }
    // db.initiallist();
    // db.loadpw();

    // db.loadpassword();
    db.updatedatabase();
    found = db.a;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("password:${db.password},${db.a.length}");
    for (int i = 0; i < db.a.length; i++) {
      if (db.a.isNotEmpty) {
        print(db.a[i]);
      }
    }
    for (int i = 0; i < db.b.length; i++) {
      if (db.b.isNotEmpty) {
        print(db.b[i]);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('T O D O')),
      ),
      floatingActionButton: Container(
        // color: Theme.of(context).primaryColor,
        height: 170,
        width: 350,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                width: double.infinity,
                child: Form(
                  key: _formkey,
                  child: TextFormField(
                    controller: _addtask,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          'E n t e r  T a s k',
                          style: TextStyle(color: Colors.white),
                        )),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Task';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          db.a.add([
                            _addtask.text.toString(),
                            DateTime.now().toString(),
                            false
                          ]);
                          db.updatedatabase();
                          _addtask.clear();
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Center(
                          child: Text(
                        'A D D',
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(3, 3),
                                spreadRadius: 1.0,
                                blurRadius: 2),
                            BoxShadow(
                              color: Colors.white30,
                              blurRadius: 3,
                              offset: Offset(-1, -1),
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _addtask.clear();
                      });
                    },
                    child: Container(
                      // color: Colors.amber,
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(3, 3),
                                spreadRadius: 1.0,
                                blurRadius: 2),
                            BoxShadow(
                              color: Colors.white30,
                              blurRadius: 3,
                              offset: Offset(-1, -1),
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(7)),
                      child: const Center(
                          child: Text(
                        'C A N C E L',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
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
              decoration: const InputDecoration(
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
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, mainAxisSpacing: 1),
                itemCount: found.length,
                itemBuilder: (context, index) {
                  return todo_tile(
                      text: found[index][0],
                      deletetask: (context) => deletetask(index),
                      index: index,
                      hidden: () {
                        setState(() {
                          db.a[index][2] = !db.a[index][2];
                          db.b.add(db.a[index]);
                          deletetask(index);
                          _mybox.put("hidelist", db.b);
                          db.updatedatabase();
                          for (int i = 0; i < db.b.length; i++) {
                            print("this is ${db.b[i][0]}");
                          }
                          // db.loadpw();
                        });
                      });
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
              Navigator.pop(context);
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Passwordmatcher()));
            },
          ),
          ListTile(
            title: Text(
              'R E S E T   P A S S W O R D',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            selected: selectedmenu == 2,
            onTap: () {
              onitemTapped(2);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => resetpw()));
            },
          )
        ]),
      ),
    );
  }
}
