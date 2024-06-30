import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class driverpage extends StatefulWidget {
  const driverpage({super.key});

  @override
  State<driverpage> createState() => _driverpageState();
}

class _driverpageState extends State<driverpage> {
  bool switched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],

        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctxt) {
                    return AlertDialog(
                      title: Center(child: Text('Do you want to exit ?')),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctxt) {
                                    return const LoginPage();
                                  }));
                            },
                            child: const Text(
                              'Yes',
                              textAlign: TextAlign.right,
                            ))
                      ],
                    );
                  });
            },
            icon: Icon(Icons.exit_to_app),
            iconSize: 30,
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Switch(
              value: switched, onChanged: (bool value) {
              setState(() {
                switched=value;
              });
            },),
          ),
        ),
      ),
    );
  }
}