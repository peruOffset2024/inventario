import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tesla/models/consulta_stock_modelo.dart';
import 'package:tesla/models/consulta_ubicacion_modelo.dart';
import 'package:http/http.dart' as http;


class StockProvider with ChangeNotifier {
  List<ConsultaStock> _itemStock = [];
  List<ConsultaUbicacion> _itemUbic = [];
  String _codScanner = '';
  bool _cargando = false;

  List<ConsultaStock> get itemStock => _itemStock;
  List<ConsultaUbicacion> get itemUbic => _itemUbic;
  String get codScanner => _codScanner;
  bool get cargando => _cargando;

  void serScannedCode(String code){
    _codScanner = code;
    notifyListeners();
  }

  Future<void> obtenerStock(String codSba) async {
    _cargando = true;
    notifyListeners();

    final urlStock =
        'http://190.107.181.163:81/amq/flutter_ajax.php?search=$codSba';
    try {
      final response = await http.get(Uri.parse(urlStock));
      if (response.statusCode == 200) {
        final List<dynamic> cuerpoRespuesta = jsonDecode(response.body);
        _itemStock = cuerpoRespuesta
            .map((item) => ConsultaStock.fromJson(item))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Error al obtener la respuesta del Api');
      }
    } catch (err) {
      _itemStock = [];
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> obtenerUbicacion(String codUbi) async {
    _cargando = true;
    notifyListeners();

    final urlUbicacion =
        "http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$codUbi";
    try {
      final responseUno = await http.get(Uri.parse(urlUbicacion));
      if (responseUno.statusCode == 200) {
        final List<dynamic> cuerpoUbi = jsonDecode(responseUno.body);
        _itemUbic = cuerpoUbi
            .map((itemUbi) => ConsultaUbicacion.fromJson(itemUbi))
            .toList();
        notifyListeners();
      } else {
        throw Exception("Error al obtener la respuesta de la Api");
      }
    } catch (e) {
      _itemUbic = [];
      _cargando = false;
      notifyListeners();
    }
  }

  void removeDataById(int id) {
    _itemUbic.removeWhere((data) => data.id == id.toString());
    notifyListeners();
  }

  Future<void> eliminarDataPorId(int ids, String nombre) async {
    try {
      final url =
          'http://190.107.181.163:81/amq/flutter_ajax_ubi_delete.php?id_ubi=$ids&usuario=$nombre';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        removeDataById(ids);
        // ignore: avoid_print
        print('Respuesta de la url al eliminar una ubicación');
      } else {
        // ignore: avoid_print
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }
}
