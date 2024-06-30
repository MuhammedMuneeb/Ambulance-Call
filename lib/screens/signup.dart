import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../database/function.dart';
import '../database/model.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController _confirmcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _mailcontroller = TextEditingController();
  String? passwordError;
  String? confirmError;
  String password = '';
  String confirm = '';
  bool _obscureText = true;

  void validate() {
    setState(() {
      if (_passwordcontroller.text == _confirmcontroller.text) {
        confirmError = null;
        print('Confirmed');
        addUser();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      } else {
        confirmError = "Password doesn't match";
        print(confirmError);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Call Amb!"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Stack(
        children: [
      Positioned.fill(
      child: Opacity(
      opacity: 0.3,
        child: Lottie.asset(
          'assets/animation/ambulance.json',
          fit: BoxFit.cover,
        ),
      )),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Container(
              //   width: 200,
              //   height: 200,
              //   child: Image.asset('assets/images/ambul.jpeg'),
              // ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _mailcontroller, // Add this line
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _obscureText=!_obscureText;
                        });
                      }, icon: Icon(
                        _obscureText? Icons.visibility:Icons.visibility_off,
                      ))
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _confirmcontroller,
                  obscureText: _obscureText,
                  decoration:  const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  validate();
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    ]
      ));
  }

  Future<void> addUser() async {
    final mail = _mailcontroller.text.trim();
    final username = _usernamecontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    if (username.isEmpty || password.isEmpty) {
      return;
    } else {
      var data = login(username: username, password: password);
      addUserList(data);
    }
  }
}