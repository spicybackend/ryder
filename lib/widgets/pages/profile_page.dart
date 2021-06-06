import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ryder/widgets/pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile coming soon',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.construction),
          ],
        ),
      ),
    );
  }
}
