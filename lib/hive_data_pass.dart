import 'package:hive/hive.dart';

class tododb {
  final _mybox = Hive.box('mybox');
  String password = "";
  List a = [];
  List b = [];
  List<List> c = [];
  List<List> d = [];

  void initialpw() {
    password = "12345";
  }

  void initiallist() {
    a = [
      ["This is your ToDo App", DateTime.now().toString(), false],
      ["Delete the Task by Sliding the Tile", DateTime.now().toString(), false],
      [
        "By double clicking you can make private",
        DateTime.now().toString(),
        false
      ]
    ];
    b = [
      ["Here is your Private notes", DateTime.now().toString(), true],
      ["Make Unhide by sliding the tile", DateTime.now().toString(), true],
    ];
  }

  void loadpassword() {
    password = _mybox.get("pw");
  }

  void loadpw() {
    // _mybox.put("publist", a);
    // _mybox.put("hidelist", b);
    a = _mybox.get("publist") ?? [];
    b = _mybox.get("hidelist") ?? [];
    // if (_mybox.get("publist") is List<List>) {
    //   a = _mybox.get("publist");
    // } else {
    //   _mybox.put("publist", a);
    // }
    // if (_mybox.get("hidelist") is List<List>) {
    //   b = _mybox.get("hidelist");
    // } else {
    //   _mybox.put("hidelist", b);
    // }
    // b = _mybox.get("hidelist") ?? [[]];
  }

  void updatedatabase() {
    _mybox.put("pw", password);
    _mybox.put("publist", a);
    _mybox.put("hidelist", b);
  }

  String getpw() {
    return password ?? "";
  }
}
