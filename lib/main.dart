import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase/supabase.dart';

import 'auth_page.dart';
import 'config/environment.dart';
import 'config/service_configuration.dart';
import 'config/ryder_theme.dart';
import 'services/auth_service.dart';
import 'utils/dependency_injection.dart';
import 'widgets/home_page.dart';

final _authService = injected<AuthService>();

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await Environment.loadEnvironment();
  ServiceConfiguration.registerServices();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ryder',
      theme: RyderTheme.lightTheme,
      darkTheme: RyderTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder<User?>(
        stream: _authService.onAuthStateChanged(),
        builder: (context, snapshot) =>
            snapshot.data == null ? AuthPage() : HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
