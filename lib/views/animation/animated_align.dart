import 'package:flutter/material.dart';

class AnimatedAling extends StatelessWidget {
  const AnimatedAling({super.key});

  static const Duration duracion = Duration(seconds: 1);
  //static const Curve curve = Curves.bounceOut; // con Rebote 
  static const Curve curve = Curves.easeInOutBack;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: AnimatedAlingExample(
        curva: curve,
        duracion: duracion,
      )),
    );
  }
}

class AnimatedAlingExample extends StatefulWidget {
  const AnimatedAlingExample(
      {super.key, required this.curva, required this.duracion});
  final Duration duracion;
  final Curve curva;

  @override
  State<AnimatedAlingExample> createState() => _AnimatedAlingExampleState();
}

class _AnimatedAlingExampleState extends State<AnimatedAlingExample> {
  bool seleted = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          seleted = !seleted;
        });
      },
      child: Center(
        child: Container(
          width: 250,
          height: 250,
          color: Colors.red,
          child: AnimatedAlign(
            alignment: seleted ? Alignment.topRight : Alignment.bottomLeft,
            duration: widget.duracion,
            curve: widget.curva,
            child:  const FlutterLogo(size: 50,),
          ),
        ),
      ),
    );
  }
}
