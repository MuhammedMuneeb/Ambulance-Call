import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import 'model.dart';

ValueNotifier<List<login>> UserList=ValueNotifier([]);
Future<void> addUserList(login value) async{
  final logindb=await Hive.openBox<login>("logindb");
  await logindb.add(value);
  UserList.value.add(value);
  UserList.notifyListeners();
}

Future<void> getUserList() async{
  final logindb=await Hive.openBox<login>("logindb");
  UserList.value.clear();
  UserList.value.addAll(logindb.values);
  UserList.notifyListeners();
}



Future<void> clearAllUsers() async{
  final logindb=await Hive.openBox<login>("logindb");
  await logindb.clear();
  UserList.value.clear();
  UserList.notifyListeners();
}