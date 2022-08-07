import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:matching_game/providers/game_over_provider.dart';
import 'package:matching_game/providers/time_counter_provider.dart';
import 'package:matching_game/utils/play_audio.dart';

class GameOverWidget extends ConsumerStatefulWidget {
  const GameOverWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<GameOverWidget> createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends ConsumerState<GameOverWidget> {
  double _width = 400;
  double _height = 400;
  BorderRadius radius = BorderRadius.circular(64);
  Color _color = Colors.deepPurple;
  bool isPlayAgain = false;

  @override
  void initState() {
    super.initState();
    PlayAudio.playAudio(Audios.toLose);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => ref.read(countDownTimerProvider.notifier).stopTimer(),);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          onEnd: () {
            Phoenix.rebirth(context);
          },
          duration: const Duration(seconds: 2),
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: _color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getChildren,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Play",
              style: TextStyle(fontFamily: "Perfect Dark BRK", fontSize: 25)),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isPlayAgain = true;
                _color = Colors.amberAccent;
                _width = 0;
                _height = 0;
              });
            },
            backgroundColor: Colors.greenAccent,
            hoverColor: Colors.amberAccent,
            child:  const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }

  List<Widget> get getChildren {
    return isPlayAgain ? [] :  [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Game Over",
                    style: TextStyle(
                        fontFamily: "Perfect Dark BRK",
                        fontSize: 40,
                        color: Colors.black)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Point = ${ref.watch(scoreProvider)}",
              style: const TextStyle(
                  fontFamily: "Perfect Dark BRK",
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Time Spent = ${ref.watch(countDownTimerProvider)} second",
              style: const TextStyle(
                  fontFamily: "Perfect Dark BRK",
                  fontSize: 20,
                  color: Colors.black),
            ),
            Expanded(
                child: Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_hliaii.json"))
          ];
  }
}
