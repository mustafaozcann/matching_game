import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_game/providers/game_over_provider.dart';
import 'package:matching_game/providers/game_table_provider.dart';
import 'package:matching_game/providers/win_provider.dart';
import 'package:matching_game/widgets/card_widget.dart';
import 'package:matching_game/widgets/game_over_widget.dart';
import 'package:matching_game/widgets/play_ground_widget.dart';
import 'package:matching_game/widgets/progress_indicator_widget.dart';
import 'package:matching_game/widgets/win_widget.dart';

// ignore: must_be_immutable
class GameTable extends ConsumerWidget {
  GameTable({Key? key}) : super(key: key);

  late List<CardWidget> cardWidget;
  bool isGameOver = false;
  bool isWin = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    cardWidget = ref.watch(cardWidgetProvider);
    isGameOver = ref.watch(gameOverProvider);
    isWin = ref.watch(gameWinProvider);
    
    return isGameOver
        ? const GameOverWidget()
        : isWin ? const WinWidget() : cardWidget.isEmpty
            ? const MyCircularProgressIndicator()
            : PlayGroundWidget(cardWidget: cardWidget);
  }
}
