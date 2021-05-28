import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/widgets/auth/sign_in_form.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/jan-kopriva-KHqAv9qQJD8-unsplash.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.75),
                ],
              ),
            ),
          ),
          WaveWidget(
            config: CustomConfig(
              gradients: [
                [Colors.red, Color(0xEEF44336)],
                [Colors.amber, Color(0x77E57373)],
                [Colors.orange, Color(0x66FF9800)],
                [Colors.yellow, Color(0x55FFEB3B)]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.70, 0.72, 0.74, 0.76],
              blur: MaskFilter.blur(BlurStyle.solid, 10),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            waveAmplitude: 1,
            size: Size(
              double.infinity,
              double.infinity,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildHeader(context),
                  SignInForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
      child: Text(
        "Ryder",
        style: GoogleFonts.permanentMarker(
          color: Colors.white,
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 64,
          shadows: [
            Shadow(
              color: Colors.amber,
              offset: Offset(-3, -5),
            ),
            Shadow(
              color: Colors.black,
              offset: Offset(2, 10),
            ),
          ],
        ),
      ),
    );
  }
}
