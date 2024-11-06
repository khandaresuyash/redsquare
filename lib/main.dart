import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.white,
      // Added a [Scaffold] as disabled [ElevatedButton] were not visible directly under [MaterialApp] & can be removed if not required.
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: SquareAnimation(),
        ),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;

  /// Current position of the red square.
  double _containerPosition = 0.0;
  double get containerPosition => _containerPosition;
  set containerPosition(double value) {
    setState(() {
      _containerPosition = value;
    });
  }

  /// Total width of the screen.
  double get screenWidth => MediaQuery.of(context).size.width;

  /// Left most position for the container based on the [screenWidth].
  double get leftMostPosition => screenWidth * 0.4;

  /// Right most position for the container based on the [screenWidth].
  double get rightMostPosition => -screenWidth * 0.4;

  /// Move the container to the left side of the screen.
  moveToLeft() {
    isMoving = true;
    containerPosition = leftMostPosition;
  }

  /// Move the container to the right side of the screen.
  moveToRight() {
    isMoving = true;
    containerPosition = rightMostPosition;
  }

  // Tracks if the container is moving or not, when the [ElevatedButton] is pressed is set to [true] & set to [false] when animation ends.
  bool _isMoving = false;
  bool get isMoving => _isMoving;
  set isMoving(bool value) {
    setState(() {
      _isMoving = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.easeIn,
          onEnd: () {
            isMoving = false;
          },
          transform: Matrix4.translationValues(_containerPosition, 0, 0),
          duration: const Duration(seconds: 1),
          child: Container(
            width: _squareSize,
            height: _squareSize,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: containerPosition == rightMostPosition || isMoving
                  ? null
                  : moveToRight,
              child: const Text('Right'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: containerPosition == leftMostPosition || isMoving
                  ? null
                  : moveToLeft,
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }
}
