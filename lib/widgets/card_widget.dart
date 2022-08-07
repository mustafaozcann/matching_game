import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:matching_game/models/card_model.dart';
import 'package:matching_game/providers/game_table_provider.dart';

class CardWidget extends ConsumerStatefulWidget {
  const CardWidget(
      {Key? key,
      required this.item,
      required this.cardKey,
      this.flipOnTouch = true})
      : super(key: key);

  final GameCard item;
  final GlobalKey<FlipCardState> cardKey;
  final bool flipOnTouch;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends ConsumerState<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: widget.cardKey,
      onFlip: () {
        ref.read(flipOnTouchProvider.notifier).state = false;
        widget.cardKey.currentState!.controller?.addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            ref.read(flipOnTouchProvider.notifier).state = true;
          }
        });
      },
      onFlipDone: (isFront) {
        if (isFront) {
          widget.item.isActive = true;
          ref.read(activeCardProvider.notifier).add(widget);
          ref.read(flipOnTouchProvider.notifier).state = true;
        } else {
          widget.item.isActive = false;
          ref.read(activeCardProvider.notifier).remove(widget);
        }
        setState(() {});
        
      },
      flipOnTouch: widget.item.isActive ? false : true,
      direction: FlipDirection.VERTICAL,
      back: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: widget.item.bgColor,
            borderRadius: BorderRadius.circular(16)),
        child: Image.asset(widget.item.path),
      ),
      front: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white)),
          child: Lottie.network(
            "https://assets10.lottiefiles.com/packages/lf20_r3bmpmp4.json",
            errorBuilder: ((context, error, stackTrace) {
              return Text(error.toString());
            }),
          )),
    );
  }
}
