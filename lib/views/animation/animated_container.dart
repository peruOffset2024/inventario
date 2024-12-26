import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: selected ? 200 : 100,
              height: selected ? 100 : 200,
              color: selected ? Colors.red : Colors.blue,
              alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
              curve: Curves.fastOutSlowIn,
              child: const FlutterLogo(size: 75,),
            )),
      ),
    );
  }
}
