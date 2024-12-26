import 'package:flutter/material.dart';
import 'package:tesla/views/iniciar_sesion.dart';
import 'package:tesla/views/scrolles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.white24,// Color del texto seleccionado
          cursorColor: Colors.black,
          selectionHandleColor: Colors.black
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4FC3F7)),
        
        useMaterial3: true,
      ),
      scrollBehavior: CustomScrollBehavior(),
      home: const MyHomePage(),
    );
  }
}