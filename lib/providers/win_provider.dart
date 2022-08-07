import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_game/providers/game_table_provider.dart';
import 'package:matching_game/providers/time_counter_provider.dart';


final gameWinProvider = StateProvider<bool>((ref) {
  ref.watch(countDownTimerProvider);
  var activeCardCount = ref.watch(cardWidgetProvider).where((element) => element.item.isActive).length;

  if(activeCardCount == 30){
    return true;
  }

  return false;
  
});
