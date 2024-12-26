import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tesla/models/items_modelo.dart';
import 'package:http/http.dart' as http;

class ItemConDiferenciasProvider with ChangeNotifier {
  List<Items> _item = [];
  List<Items> _filtrarItem = [];
  bool _cargando = false;

  List<Items> get item => _filtrarItem;
  bool get cargando => _cargando;

  Future<void> traerItems() async {
    _cargando = true;
    notifyListeners();

    const url = 'http://190.107.181.163:81/amq/flutter_ajax_home.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final respuestaJson = jsonDecode(response.body);
        if (respuestaJson is Map<String, dynamic> &&
            respuestaJson.containsKey('error')) {
          _item = [];
          _filtrarItem = [];
        } else if (respuestaJson is List<dynamic>) {
          _item = respuestaJson.map((item) => Items.fromJson(item)).toList();
          _filtrarItem = _item;
        } else {
          throw Exception("No es el formato correcto");
        }
      } else {
        throw Exception('Error al traer los datos');
      }
    } catch (err) {
      print('Error: $err');
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  void buscarItems(String query) {
  if (query.isEmpty) {
    _filtrarItem = _item;
  } else {
    _filtrarItem = _item.where((item) {
      return item.descripcion.toLowerCase().contains(query.toLowerCase()) ||
             item.itemCode.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Ordena los resultados para mostrar coincidencias al inicio del texto primero
    _filtrarItem.sort((a, b) {
      final descripcionA = a.descripcion.toLowerCase();
      final descripcionB = b.descripcion.toLowerCase();
      final itemCodeA = a.itemCode.toLowerCase();
      final itemCodeB = b.itemCode.toLowerCase();

      // Ordenar según si el inicio coincide primero
      final matchA = descripcionA.startsWith(query.toLowerCase()) || 
                     itemCodeA.startsWith(query.toLowerCase()) ? 0 : 1;
      final matchB = descripcionB.startsWith(query.toLowerCase()) || 
                     itemCodeB.startsWith(query.toLowerCase()) ? 0 : 1;

      return matchA.compareTo(matchB);
    });
  }
  notifyListeners();
}

}
