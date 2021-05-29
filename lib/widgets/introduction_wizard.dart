import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ryder/exceptions/profile_exception.dart';
import 'package:ryder/services/profile_service.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../exceptions/auth_exception.dart';
import '../utils/dependency_injection.dart';

final _profileService = injected<ProfileService>();

class IntroductionWizard extends StatelessWidget {
  final _profileFormKey = GlobalKey<FormState>(debugLabel: 'profile-form');
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          Container(color: Colors.white),
          WaveWidget(
            config: CustomConfig(
              colors: [
                Colors.orange,
                Colors.yellow,
                Colors.amber,
              ],
              durations: [19440, 10800, 6000],
              heightPercentages: [0.80, 0.81, 0.82],
              blur: MaskFilter.blur(BlurStyle.solid, 10),
            ),
            waveAmplitude: 1.5,
            size: Size(
              double.infinity,
              double.infinity,
            ),
          ),
          IntroductionScreen(
            globalBackgroundColor: Colors.transparent,
            dotsDecorator: DotsDecorator(
              activeColor: Colors.black,
              color: Colors.black38,
            ),
            doneColor: Colors.black,
            nextColor: Colors.black,
            pages: [
              PageViewModel(
                title: "Bikes, bikes, bikes!",
                body:
                    "Here you'll find mates that are just as enthusiastic about biking as you are!",
                image: Center(
                  child: SvgPicture.asset(
                    "images/undraw_Ride_a_bicycle_2yok.svg",
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
              PageViewModel(
                title: "Another thing",
                body:
                    "More text here explaining some features. More text here explaining some features.",
                image: Center(
                  child: SvgPicture.asset(
                    "images/undraw_add_tasks_mxew.svg",
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
              PageViewModel(
                title: "Profile",
                bodyWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        "To get started, add some details about yourself.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 24.0,
                        ),
                        child: Form(
                          key: _profileFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _usernameController,
                                autofillHints: [AutofillHints.username],
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  if (value.length < 3) {
                                    return 'Needs to be at least three characters long';
                                  }

                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _bioController,
                                minLines: 3,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText: 'Bio (optional)',
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                image: Center(
                  child: SvgPicture.asset(
                    "images/undraw_Private_data_re_4eab.svg",
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
            ],
            done: const Text(
              "Send it!",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            showNextButton: true,
            next: Text("Next"),
            onDone: () async {
              if (_profileFormKey.currentState!.validate()) {
                try {
                  await _profileService.create(
                    username: _usernameController.text.trim(),
                    bio: _bioController.text.trim(),
                  );

                  Navigator.of(context).pop();
                } on ProfileException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message)),
                  );
                } on AuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message)),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
