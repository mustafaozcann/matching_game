import 'package:audioplayers/audioplayers.dart';

enum Audios { correctMatch, missMatch, toLose , flip, win}

class PlayAudio {
  static AudioPlayer player = AudioPlayer();

  static void playAudio(Audios state) {
    AudioCache cache = AudioCache(prefix: "lib/assets/");
    player.audioCache = cache;

    switch (state) {
      case Audios.win:
        player.play(AssetSource("audios/win.wav"));
        break;
      case Audios.correctMatch:
        player.play(AssetSource("audios/correctMatch.wav"));
        break;
      case Audios.missMatch:
        player.play(AssetSource("audios/misMatch.wav"));
        break;
      case Audios.toLose:
        player.play(AssetSource("audios/lose.wav"));
        break;
      case Audios.flip:
        player.play(AssetSource("audios/flip.wav"));
        break;
      default:
        player.play(AssetSource("audios/misMatch.wav"));
        break;

        
    }

  }
}
