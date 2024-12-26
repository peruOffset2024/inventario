import 'package:flutter/material.dart';

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({super.key});

  @override
  State<AnimatedPositionedExample> createState() => _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 350,
          child: Stack(
            children: [
              AnimatedPositioned(
                width: selected ? 200.0 : 50.00,
                height: selected ? 50.0 : 200.0, 
                top: selected ? 50.0 : 150.0,
                duration: const Duration(seconds: 1), 
                child:  GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: const ColoredBox(color: Colors.blue, child: Center(child: Text('Tap me'),),)),)
            ],
          ),
        ),
      ),
    );
  }
}