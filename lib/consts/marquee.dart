import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeAppbar extends StatelessWidget {
  //const Marquee({Key? key}) : super(//key: key);

  const MarqueeAppbar(this.text, {Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: text,
      pauseAfterRound: const Duration(seconds: 1),
      blankSpace: 40.0,
      velocity: 50,
      style: const TextStyle(fontSize: 14),
      decelerationCurve: Curves.easeOut,
    );
  }
}
