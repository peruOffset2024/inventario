import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ZonaProvider with ChangeNotifier{
  List<String> _zona = [];

  List<String> get zona => _zona;

  Future<void> zonaUbicacion() async {
    const url = 'http://190.107.181.163:81/amq/flutter_ajax_zona.php';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final cuerpoZona = jsonDecode(response.body);
        _zona = cuerpoZona.map<String>((zona) => zona['descripcion'].toString()).toList(); 
        notifyListeners();  
      } else {
        throw Exception('Error al obtener la respuesta del servidor');
      }
    }catch(err){
      _zona = [];
      notifyListeners();
      print('Error: $err');
    }
  }
}

class StandProvider with ChangeNotifier {
  List<String> _stand = [];

  List<String> get stand => _stand;

  Future<void> standUbicacion() async {
    const url = 'http://190.107.181.163:81/amq/flutter_ajax_stand.php';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final  cuerpoStand = jsonDecode(response.body);
        _stand = cuerpoStand.map<String>((stand)=> stand['descripcion'].toString()).toList();
        notifyListeners();
      } else {
        throw Exception('Error al obtener la respuesta del servidor');
      }
    } catch(e) {
      _stand = [];
      notifyListeners();
      print('Error: $e');
    }
  }
}