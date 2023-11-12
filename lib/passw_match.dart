import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_bharat_clone/hiddenpage.dart';
import 'package:todo_list_bharat_clone/hive_data_pass.dart';

class Passwordmatcher extends StatefulWidget {
  @override
  State<Passwordmatcher> createState() => _PasswordmatcherState();
}

class _PasswordmatcherState extends State<Passwordmatcher> {
  final _mybox = Hive.box('mybox');
  TextEditingController _password = TextEditingController();
  final _formkey2 = GlobalKey<FormState>();
  bool obtext = true;
  tododb db = tododb();
  @override
  void initState() {
    // TODO: implement initState
    // db.initialpw();
    db.loadpassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('T O D O')),
      ),
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
                      keyboardType: TextInputType.number,
                      controller: _password,
                      obscureText: obtext,
                      decoration: const InputDecoration(
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
              const SizedBox(
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
          // const SizedBox(
          //   height: 5,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: InkWell(
              onTap: () {
                if (_formkey2.currentState!.validate()) {
                  setState(() {
                    if (_password.text.trim() ==
                        db.password.toString().trim()) {
                      print(db.password);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HiddenPage()),
                      );
                    } else {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            dismissDirection: DismissDirection.down,
                            behavior: SnackBarBehavior.floating,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Color.fromARGB(255, 30, 161, 227),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            content: Text(
                              'Password doesn\'t match',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      });
                    }
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
