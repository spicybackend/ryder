import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase/supabase.dart';

import '../../services/auth_service.dart';
import '../../utils/dependency_injection.dart';

final _authService = injected<AuthService>();

class SocialSignInButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final Provider provider;

  SocialSignInButton({
    required this.assetPath,
    required this.label,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        onPressed: () => _authService.signInWithProvider(provider),
        child: SizedBox(
          width: 42,
          height: 42,
          child: SvgPicture.asset(
            assetPath,
            semanticsLabel: label,
          ),
        ),
      ),
    );
  }
}
