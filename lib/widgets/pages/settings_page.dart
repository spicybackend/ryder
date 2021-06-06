import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ryder/services/auth_service.dart';
import 'package:ryder/utils/dependency_injection.dart';

final _authService = injected<AuthService>();

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.of(context).pop();
              },
              child: Text("Log out"),
            )
          ],
        ),
      ),
    );
  }
}
