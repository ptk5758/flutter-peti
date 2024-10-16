import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '운동량 측정 앱',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MovementDetectorPage(),
    );
  }
}

class MovementDetectorPage extends StatefulWidget {
  @override
  _MovementDetectorPageState createState() => _MovementDetectorPageState();
}

class _MovementDetectorPageState extends State<MovementDetectorPage> {
  String _movement = '정지';
  double _threshold1 = 1.0; // 걷기 임계값
  double _threshold2 = 5.0; // 뛰기 임계값
  Timer? _timer;
  List<double> _magnitudes = [];

  @override
  void initState() {
    super.initState();
    _startListening();
    _startTimer();
  }

  void _startListening() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      double magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z) - 9.8;
      _magnitudes.add(magnitude.abs());
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_magnitudes.isNotEmpty) {
        double averageMagnitude = _magnitudes.reduce((a, b) => a + b) / _magnitudes.length;
        setState(() {
          if (averageMagnitude < _threshold1) {
            _movement = '정지';
          } else if (averageMagnitude < _threshold2) {
            _movement = '걷기';
          } else {
            _movement = '뛰기';
          }
        });
        _magnitudes.clear();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('운동량 측정')),
      body: Center(
        child: Text(
          _movement,
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}