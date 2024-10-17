import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import '../models/movement_state.dart';
import '../utils/movement_utils.dart';

class AccelerometerService {
  final _magnitudes = <double>[];
  StreamSubscription? _subscription;
  Timer? _timer;

  void startListening(Function(MovementState) onMovementDetected) {
    _subscription = accelerometerEvents.listen((event) {
      double magnitude = calculateMagnitude(event.x, event.y, event.z);
      _magnitudes.add(magnitude);
    });

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_magnitudes.isNotEmpty) {
        double averageMagnitude =
            _magnitudes.reduce((a, b) => a + b) / _magnitudes.length;
        MovementState movementState = getMovementState(averageMagnitude);
        onMovementDetected(movementState);
        _magnitudes.clear();
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
    _timer?.cancel();
  }
}
