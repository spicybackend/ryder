import 'package:flutter/material.dart';

import '../../../exceptions/auth_exception.dart';
import '../../../services/auth_service.dart';
import '../../../utils/dependency_injection.dart';

final _authService = injected<AuthService>();

class EmailSignInForm extends StatefulWidget {
  final void Function() onRegister;

  const EmailSignInForm({Key? key, required this.onRegister}) : super(key: key);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailFormKey = GlobalKey<FormState>(debugLabel: 'sign-in-form');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'auth-form',
      child: Padding(
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
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  autofillHints: [AutofillHints.password],
                  obscureText: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: _isBusy ? null : (_) => _submit(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Reset password
                      print(_authService.currentUser?.email ?? 'not signed in');
                    },
                    child: Text("Recover password"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: _isBusy
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              )
                            : Text("Sign in"),
                        onPressed: _isBusy ? null : () => _submit(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text("Register"),
                        onPressed: widget.onRegister,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _submit() async {
    if (_emailFormKey.currentState!.validate()) {
      setState(() {
        _isBusy = true;
      });

      try {
        await _authService.signIn(
          _emailController.text,
          _passwordController.text,
        );
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      } finally {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }
}
