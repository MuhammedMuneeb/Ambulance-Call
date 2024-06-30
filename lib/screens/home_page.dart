import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';
import '../database/model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctxt) {
                            return const LoginPage();
                          }));
                        },
                        child: const Text(
                          'Yes',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.exit_to_app),
            iconSize: 30,
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Driver>('driverBox').listenable(),
        builder: (context, Box<Driver> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No drivers added'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Driver? driver = box.getAt(index);
              return ListTile(
                leading: CircleAvatar(
                  child: Text(driver?.name[0] ?? '?'),
                ),
                title: Text(driver?.name ?? 'No Name'),
                subtitle: Text(driver?.location ?? 'No Location'),
                trailing: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _makePhoneCall(driver?.phoneNumber ?? '');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
