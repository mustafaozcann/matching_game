import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class CountDownTimerNotifier extends StateNotifier<int>{
  CountDownTimerNotifier() : super(131);

  late Timer timer;

  update(int time){
    state = time;
  }

  startTimer() {
    const oneSec = Duration(seconds: 1);
    int start = 1000;

    timer = Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        stopTimer();
        
      } else {
        start--;
        update(start);
        
      }
    });


  }

  stopTimer(){
    timer.cancel();
    state = timer.tick;
  }


}
final countDownTimerProvider = StateNotifierProvider<CountDownTimerNotifier,int>((ref) {
  return CountDownTimerNotifier();
});


