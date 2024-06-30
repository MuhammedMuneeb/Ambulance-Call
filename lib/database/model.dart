import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class login extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  String? mail;
  @HiveField(2)
  final String password;
  login({required this.username, required this.password, this.mail});
}

@HiveType(typeId: 2)
class Driver extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String location;
  @HiveField(2)
  final String phoneNumber;

  Driver({required this.name, required this.location, required this.phoneNumber});
}
