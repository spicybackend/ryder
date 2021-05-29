import 'package:flutter/material.dart';

import '../../../exceptions/auth_exception.dart';
import '../../../services/auth_service.dart';
import '../../../utils/dependency_injection.dart';

final _authService = injected<AuthService>();

class EmailRegistrationForm extends StatefulWidget {
  final void Function() onCancel;

  const EmailRegistrationForm({Key? key, required this.onCancel})
      : super(key: key);

  @override
  _EmailRegistrationFormState createState() => _EmailRegistrationFormState();
}

class _EmailRegistrationFormState extends State<EmailRegistrationForm> {
  final _emailFormKey = GlobalKey<FormState>(debugLabel: 'registration-form');
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
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
                    labelText: 'Password confirmation',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Just to double-check';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: _isBusy
                            ? CircularProgressIndicator()
                            : Text("Register"),
                        onPressed: _isBusy
                            ? null
                            : () async {
                                if (_emailFormKey.currentState!.validate()) {
                                  setState(() {
                                    _isBusy = true;
                                  });

                                  try {
                                    final user = await _authService.signIn(
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
                              },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text("Cancel"),
                        onPressed: widget.onCancel,
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
}