import 'package:ambulance_call/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/model.dart';
import 'driver_page.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  String? selectedValue;
  bool _obscureText = true;

  Future<void> validate() async {
    final logindb = await Hive.openBox<login>('logindb');
    for (var user in logindb.values) {
      if (user.username == _usernamecontroller.text &&
          user.password == _passwordcontroller.text) {
        loginInfo();
        if (selectedValue == 'User') {
          Fluttertoast.showToast(msg: "Login successfully");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return userpage();
          }));
          return;
        } else if (selectedValue == 'Driver') {
          Fluttertoast.showToast(msg: "Login successfully");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return driver();
          }));
          return;
        }
      }
    }
    Fluttertoast.showToast(msg: "Invalid user");
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<String> items = ['User', 'Driver'];
    return items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(color: Colors.black87),
        ),
      );
    }).toList();
  }

  void loginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernamecontroller.text);
    prefs.setString('password', _passwordcontroller.text);
    prefs.setString('userType', selectedValue ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 250,
                height: 250,
                child: Lottie.asset('assets/animation/lottti.json'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _usernamecontroller,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _passwordcontroller,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  icon: const Icon(Icons.account_circle),
                  hint: const Text(
                    'Select Login',
                    style: TextStyle(color: Colors.black87),
                  ),
                  iconSize: 20,
                  iconEnabledColor: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  style: const TextStyle(color: Colors.white),
                  items: getDropdownMenuItems(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  value: selectedValue,
                ),
              ),
              ElevatedButton(
                onPressed: selectedValue == null ? null : () {
                  validate();
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("New user? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
