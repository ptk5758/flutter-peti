import 'package:flutter/material.dart';
import '../models/movement_state.dart';

class MovementDisplay extends StatelessWidget {
  final MovementState movementState;

  const MovementDisplay({Key? key, required this.movementState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayText;
    switch (movementState) {
      case MovementState.walking:
        displayText = '걷기';
        break;
      case MovementState.running:
        displayText = '뛰기';
        break;
      default:
        displayText = '정지';
        break;
    }

    return Text(
      displayText,
      style: TextStyle(fontSize: 48),
    );
  }
}
