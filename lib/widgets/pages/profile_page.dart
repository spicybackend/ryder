import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ryder/models/profile.dart';
import 'package:ryder/services/profile_service.dart';
import 'package:ryder/utils/dependency_injection.dart';
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
        child: FutureBuilder<Profile?>(
            future: injected<ProfileService>().currentUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data == null) {
                return Text("guts");
              }

              final profile = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile.username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.account_circle),
                ],
              );
            }),
      ),
    );
  }
}
