import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_game/models/card_model.dart';
import 'package:matching_game/providers/game_table_provider.dart';
import 'package:matching_game/utils/get_card_list.dart';
import 'package:matching_game/widgets/card_widget.dart';


class PrepareCard {
  static Future<void> prepare(WidgetRef ref) async {
    List<GameCard> allCards = await GetCard.getAllCards();
    List<GlobalKey<FlipCardState>> cardKeys = [];
    List<GameCard> randomGameCard = [];

    List<CardWidget> cardWidgets = [];
    int rndIndex = 0;
    var beFormedRndIndexList = [];

    for (int i = 0; i < allCards.length - 35; i++) {
      rndIndex = Random().nextInt(50);
      while (beFormedRndIndexList.contains(rndIndex)) {
        rndIndex = Random().nextInt(50);
      }

      randomGameCard.add(GameCard(
          id: allCards[rndIndex].id,
          path: allCards[rndIndex].path,
          bgColor: allCards[rndIndex].bgColor));
      randomGameCard.add(GameCard(
          id: allCards[rndIndex].id,
          path: allCards[rndIndex].path,
          bgColor: allCards[rndIndex].bgColor));
      beFormedRndIndexList.add(rndIndex);
    }
    randomGameCard.shuffle();

    for (int i = 0; i < randomGameCard.length; i++) {
      randomGameCard[i].index = i + 1;
      cardKeys.add(GlobalKey<FlipCardState>());
      cardWidgets
          .add(CardWidget(item: randomGameCard[i], cardKey: cardKeys[i]));
    }

    ref.read(cardWidgetProvider.notifier).state = cardWidgets;


    //for test
    for (var element in cardWidgets) {
      debugPrint("ID:${element.item.id} Index : ${element.item.index}");
    }
  }

}
