import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:matching_game/screens/game_page.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenExampleState();
}

class _MySplashScreenExampleState extends State<MySplashScreen> {


  void goToGamePage() async {
    Future(
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const GamePage()))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Perfect Dark BRK',
          ),
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            onFinished: () => goToGamePage(),
            animatedTexts: [
              TypewriterAnimatedText('Loading...',textAlign: TextAlign.center, speed: const Duration(milliseconds: 200)),
            ],
          ),
        ),
      ),
    );
  }
}
