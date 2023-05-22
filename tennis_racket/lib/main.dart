import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';


void main() {
  runApp(TennisGameScreen());
}

class TennisGameScreen extends StatefulWidget {
  @override
  _TennisGameScreenState createState() => _TennisGameScreenState();
}

class _TennisGameScreenState extends State<TennisGameScreen> {
  double _forceValue = 0.0;
  double _rotationAngle = 0.0;
  double mass = 5.0 ;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      final double force = event.z * mass;
      setState(() {
        _forceValue = force;
      });
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      final double rotation = degrees(event.y);
      setState(() {
        _rotationAngle = rotation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tennis Game'),
        ),
        body: Center(
         child: Column(
          children: [
            Transform.rotate(
              angle: radians(_rotationAngle),
              child: Container(
                width: 300,
                height: 300,
                child :Row(children: [
                  const Text(
                    'Rotation Angel:',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    _forceValue.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.limeAccent
                    ),
                  ),
                ],),

                //color: Colors.cyan,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Force Value:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _forceValue.toStringAsFixed(2),
              style: TextStyle(fontSize: 48,
                 // color: Colors.limeAccent
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerEvents.drain();
    gyroscopeEvents.drain();
  }
}