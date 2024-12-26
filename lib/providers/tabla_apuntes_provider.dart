import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureProvider with ChangeNotifier {
  SignatureController _controller;

  SignatureProvider()
      : _controller = SignatureController(
          penStrokeWidth: 5,
          penColor: Colors.black,
          exportBackgroundColor: Colors.white,
        );

  SignatureController get controller => _controller;

  void clearSignature() {
    _controller.clear();
    notifyListeners();
  }

  void activateEraser() {
    _setController(penColor: Colors.white, penStrokeWidth: 15);
    notifyListeners();
  }

  void deactivateEraser() {
    _setController(penColor: Colors.black, penStrokeWidth: 5);
    notifyListeners();
  }

  void updatePenColor(Color color) {
    _setController(penColor: color);
    notifyListeners();
  }

  void updatePenStrokeWidth(double width) {
    _setController(penStrokeWidth: width);
    notifyListeners();
  }

  void _setController({Color? penColor, double? penStrokeWidth}) {
    _controller = SignatureController(
      penColor: penColor ?? _controller.penColor,
      penStrokeWidth: penStrokeWidth ?? _controller.penStrokeWidth,
      exportBackgroundColor: Colors.white,
    );
    notifyListeners();
  }
}
