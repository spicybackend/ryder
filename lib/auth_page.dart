import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/widgets/auth/auth_form.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
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
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildHeader(context),
                  AuthForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
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
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 200,
      child: AnimatedHeader(),
    );
  }
}

class AnimatedHeader extends StatefulWidget {
  @override
  _AnimatedHeaderState createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;
  late final AnimationController _controllerTwo;
  late final Animation<Offset> _animationTwo;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: true);
    _animation = Tween(
      begin: Offset(0.02, -0.05),
      end: Offset(-0.05, 0.02),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ),
    );

    _controllerTwo = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _animationTwo = Tween(
      begin: Offset(0.01, 0.015),
      end: Offset(-0.065, -0.045),
    ).animate(
      CurvedAnimation(
        parent: _controllerTwo,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerTwo.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: _animation,
          child: Text(
            "Ryder",
            textAlign: TextAlign.center,
            style: GoogleFonts.permanentMarker(
              color: Colors.amber,
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 68,
            ),
          ),
        ),
        SlideTransition(
          position: _animationTwo,
          child: Text(
            "Ryder",
            textAlign: TextAlign.center,
            style: GoogleFonts.permanentMarker(
              color: Colors.black,
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 70,
            ),
          ),
        ),
        Text(
          "Ryder",
          textAlign: TextAlign.center,
          style: GoogleFonts.permanentMarker(
            color: Colors.white,
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 64,
          ),
        ),
      ],
    );
  }
}
