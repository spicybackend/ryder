import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ryder/registration_page.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailFormKey = Key('auth-form');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEmailSignInForm(),
        _buildFormSeparator(),
        _buildSocialAuthOptions(),
      ],
    );
  }

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

  Widget _buildEmailSignInForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 10),
                blurRadius: 25,
              ),
            ]),
        child: Form(
          key: _emailFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Recover password"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text("Sign in"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text("Register"),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegistrationPage()),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialAuthOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          assetPath: "images/google_g_logo.svg",
          label: 'Google',
          onPressed: () {},
        ),
        _buildSocialButton(
          assetPath: "images/apple_logo_black.svg",
          label: 'Apple ID',
          onPressed: () {},
        ),
        _buildSocialButton(
          assetPath: "images/facebook_f_logo.svg",
          label: 'Facebook',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String assetPath,
    required String label,
    void Function()? onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextButton(
        onPressed: onPressed,
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
