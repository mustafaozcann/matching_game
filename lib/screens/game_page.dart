import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_game/providers/time_counter_provider.dart';

import 'package:matching_game/utils/prepare_card.dart';
import 'package:matching_game/widgets/game_table.dart';


class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  void initState() {
    super.initState();
    PrepareCard.prepare(ref);
    ref.read(countDownTimerProvider.notifier).startTimer();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Match The Cards",
          style: TextStyle(color: Colors.white, fontFamily: "Perfect Dark BRK"),
        ),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
      color: Colors.black,
      child: Padding(padding: const EdgeInsets.all(8.0), child: GameTable()),
    );
  }
}
