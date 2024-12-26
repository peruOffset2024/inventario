import 'package:flutter/material.dart';


class FadeTrasnsitionMain extends StatelessWidget {
  const FadeTrasnsitionMain({super.key});

  static const Duration duration = Duration(seconds: 2);
  static const Curve curves = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return const FadeTrasnsitionExample(duracion: duration, curve: curves,);
  }
}

class FadeTrasnsitionExample extends StatefulWidget {
  const FadeTrasnsitionExample({super.key, required this.duracion, required this.curve});
  
  final Duration duracion;
  final Curve curve;

  @override
  State<FadeTrasnsitionExample> createState() => _FadeTrasnsitionExampleState();
}

class _FadeTrasnsitionExampleState extends State<FadeTrasnsitionExample>
    with TickerProviderStateMixin {


  late final AnimationController _controller =
      AnimationController(duration: widget.duracion, vsync: this)
        ..repeat(reverse: true);

  late final CurvedAnimation _animation =
      CurvedAnimation(parent: _controller, curve: widget.curve);
  
  void didUpdateWidget(FadeTrasnsitionExample oldWidget){
    super.didUpdateWidget(oldWidget);
    if(oldWidget.duracion != widget.duracion ){
      _controller..duration = widget.duracion..repeat(reverse: true);
    }
    
    if(oldWidget.curve != oldWidget.curve){
      _animation.curve = widget.curve;
    }

  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: Colors.white,
    child: FadeTransition(opacity: _animation, 
    child: const Padding(padding: EdgeInsets.all(8), child: FlutterLogo(),),),);
  }
}
