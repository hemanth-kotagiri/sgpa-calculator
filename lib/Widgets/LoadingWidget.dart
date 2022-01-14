import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String animatedText;
  const LoadingWidget({Key key, @required this.animatedText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 17,
                color: Colors.white.withOpacity(0.3),
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(animatedText),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
