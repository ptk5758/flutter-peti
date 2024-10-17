import 'package:flutter/material.dart';
import '../services/accelerometer_service.dart';
import '../models/movement_state.dart';
import '../widgets/movement_display.dart';

class MovementDetectorPage extends StatefulWidget {
  @override
  _MovementDetectorPageState createState() => _MovementDetectorPageState();
}

class _MovementDetectorPageState extends State<MovementDetectorPage> {
  MovementState _movementState = MovementState.stationary;
  final AccelerometerService _accelerometerService = AccelerometerService();

  @override
  void initState() {
    super.initState();
    _accelerometerService.startListening((movementState) {
      setState(() {
        _movementState = movementState;
      });
    });
  }

  @override
  void dispose() {
    _accelerometerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('운동량 측정')),
      body: Center(
        child: MovementDisplay(movementState: _movementState),
      ),
    );
  }
}
