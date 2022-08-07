import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_game/providers/heart_provider.dart';
import 'package:matching_game/utils/play_audio.dart';
import 'package:matching_game/widgets/card_widget.dart';


final cardWidgetProvider = StateProvider<List<CardWidget>>((ref) {
  return <CardWidget>[];
});
//*******
//
//
//
// */
class ActiveCardNotifier extends StateNotifier<List<CardWidget>> {
  ActiveCardNotifier() : super(<CardWidget>[]);

  add(CardWidget widget) {
    PlayAudio.playAudio(Audios.flip);
    if (state.isNotEmpty) {
      state = [
        ...state,
        for (var i in state)
          if (widget.item.index != i.item.index) widget
      ];
    } else {
      state = [...state, widget];
    }
  }

  remove(CardWidget widget) {
    state = [
      for (var i in state)
        if (i.item.id != widget.item.id) i,
    ];
  }

  removeAll() {
    for (var i in state) {
      i.item.isActive = true;
    }
    state = <CardWidget>[];
  }
}

final activeCardProvider =
    StateNotifierProvider<ActiveCardNotifier, List<CardWidget>>((ref) {
  return ActiveCardNotifier();
});

final controlProvider = StateProvider<void>((ref) {
  Future.delayed(Duration.zero, (() {
    var list = ref.watch(activeCardProvider);

    if (list.length == 2) {
      var firstCard = list[0];
      var secondCard = list[1];

      if (firstCard.item.id != secondCard.item.id) {
        for (var element in list) {
          element.cardKey.currentState!.toggleCard();
        }
        ref.read(heartProvider.notifier).update((state) => state - 1);
        PlayAudio.playAudio(Audios.missMatch);

      } else {
        ref.read(activeCardProvider.notifier).removeAll();
        PlayAudio.playAudio(Audios.correctMatch);

      }
    }
  }));
});


final flipOnTouchProvider = StateProvider<bool>((ref) {
  return true;
});