import 'dart:math';

import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int _currentStep = 0;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildStepper(),
            ],
          ),
        ),
      ),
    );
  }

  bool get _accountDetailsAreValid {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Widget _buildStepper() {
    return Stepper(
      onStepContinue: () {
        setState(() {
          _currentStep += 1;
        });
      },
      onStepCancel: () {
        setState(() {
          _currentStep = max(_currentStep - 1, 0);
        });
      },
      steps: [
        Step(
          title: new Text('Account'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state:
              _accountDetailsAreValid ? StepState.complete : StepState.editing,
        ),
        Step(
          title: new Text('Profile'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Avatar'),
              ),
            ],
          ),
          isActive: _currentStep >= 1,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
      ],
    );
  }
}
