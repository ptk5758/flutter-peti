import 'dart:math';

import 'package:ondevice/models/movement_state.dart';

double calculateMagnitude(double x, double y, double z) {
  return sqrt(x * x + y * y + z * z) - 9.8;
}

MovementState getMovementState(double magnitude) {
  if (magnitude < 1.0) {
    return MovementState.stationary;
  } else if (magnitude < 5.0) {
    return MovementState.walking;
  } else {
    return MovementState.running;
  }
}
