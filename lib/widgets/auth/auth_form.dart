import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import 'auth_form/email_registration_form.dart';
import 'auth_form/email_sign_in_form.dart';
import 'social_sign_in_button.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final bool _isSocialSignInEnabled = false;
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final signInForm = EmailSignInForm(onRegister: () => _switchForms());
    final registrationForm =
        EmailRegistrationForm(onCancel: () => _switchForms());

    return Column(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _isRegistering ? registrationForm : signInForm,
        ),
        if (_isSocialSignInEnabled) ...[
          _buildFormSeparator(),
          _buildSocialAuthOptions(),
        ],
      ],
    );
  }

  void _switchForms() => setState(() {
        _isRegistering = !_isRegistering;
      });

  Widget _buildFormSeparator() {
    final divider = Expanded(
      child: Divider(
        indent: 20,
        endIndent: 20,
        color: Colors.blue,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        children: [
          divider,
          Text("Or continue with"),
          divider,
        ],
      ),
    );
  }

  Widget _buildSocialAuthOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialSignInButton(
          assetPath: "images/google_g_logo.svg",
          label: 'Google',
          provider: Provider.google,
        ),
        // SocialSignInButton(
        //   assetPath: "images/apple_logo_black.svg",
        //   label: 'Apple ID',
        //   onPressed: () => _authService.signInWithProvider(Provider.apple),
        // ),
        SocialSignInButton(
          assetPath: "images/facebook_f_logo.svg",
          label: 'Facebook',
          provider: Provider.facebook,
        ),
      ],
    );
  }
}
