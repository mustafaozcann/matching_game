import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_game/providers/time_counter_provider.dart';




class TimeCounterWidget extends ConsumerWidget {
  const TimeCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  AnimatedFlipCounter(
      fractionDigits: 2,
      value: ref.watch(countDownTimerProvider),
      textStyle: TextStyle(
        fontFamily: "Perfect Dark BRK",
        fontSize: 80,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
        color: ref.watch(countDownTimerProvider) >= 10 ? Colors.greenAccent : Colors.redAccent,
      ),
    );
  }


}

