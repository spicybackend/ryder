import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ryder/auth_page.dart';
import 'package:ryder/config/ryder_theme.dart';

import 'config/environment.dart';
import 'config/service_configuration.dart';

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
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
