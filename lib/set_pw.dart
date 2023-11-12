// import 'dart:html';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_bharat_clone/Home_Page.dart';
import 'package:todo_list_bharat_clone/hive_data_pass.dart';

class setpassword extends StatefulWidget {
  @override
  State<setpassword> createState() => _setpasswordState();
}

class _setpasswordState extends State<setpassword> {
  final _mybox = Hive.box("mybox");
  TextEditingController _password = TextEditingController();
  tododb db = tododb();
  final _formkey2 = GlobalKey<FormState>();

  bool obtext = true;
  @override
  void initState() {
    // TODO: implement initState
    if (_mybox.get("pw") == null) {
      db.initialpw();
      db.initiallist();
    } else {
      db.loadpw();
    }
    db.updatedatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('T O D O')),
      ),
      // body: Container(),
      body: Padding(
        padding: const EdgeInsets.only(right: 40.0, left: 40, top: 300),
        child: Column(children: [
          Center(
              child: Row(
            children: [
              Expanded(
                child: Container(
                  // margin: EdgeInsets.only(top: 300),
                  width: 200,
                  child: Form(
                    key: _formkey2,
                    child: TextFormField(
                      controller: _password,
                      obscureText: obtext,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          'E N T E R      P A S S W O R D',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    obtext = !obtext;
                  });
                },
                child:
                    (obtext == true) ? Icon(Icons.lock) : Icon(Icons.lock_open),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: InkWell(
              onTap: () {
                if (_formkey2.currentState!.validate()) {
                  setState(() {
                    String a = _password.text.trim();
                    print("real");
                    print(a);
                    db.password = a;
                    db.updatedatabase();
                    print("db");
                    print(db.password);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    // pass = _password.text.toString().trim();
                    // db.pass = _password.text;
                  });
                }
              },
              child: Container(
                width: 100,
                height: 50,
                child: Center(
                    child: Text(
                  'G O  I N',
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
        ]),
      ),
    );
  }
}
