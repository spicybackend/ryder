import 'package:flutter/material.dart';

import '../../../exceptions/auth_exception.dart';
import '../../../services/auth_service.dart';
import '../../../utils/dependency_injection.dart';
import '../../introduction_wizard.dart';

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
  final _passwordConfirmationController = TextEditingController();

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
                    if (!value.contains('@')) {
                      return 'That doesn\'t quite look right';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  autofillHints: [AutofillHints.newPassword],
                  obscureText: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Needs to be at least six characters long';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordConfirmationController,
                  obscureText: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password confirmation',
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: _isBusy ? null : (_) => _submit(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requied to double-check your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Whoops, your passwords don\'t match';
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
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              )
                            : Text("Register"),
                        onPressed: _isBusy ? null : () => _submit(),
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

  Future _submit() async {
    if (_emailFormKey.currentState!.validate()) {
      setState(() {
        _isBusy = true;
      });

      try {
        await _authService.register(
          email: _emailController.text,
          password: _passwordController.text,
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
