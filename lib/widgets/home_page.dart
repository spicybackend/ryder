import 'package:flutter/material.dart';
import 'package:ryder/services/profile_service.dart';

import '../services/auth_service.dart';
import '../utils/dependency_injection.dart';
import 'introduction_wizard.dart';

final _authService = injected<AuthService>();
final _profileService = injected<ProfileService>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final userHasProfile = await _profileService.hasProfile();

      if (!userHasProfile) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => IntroductionWizard(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("All logged in"),
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
