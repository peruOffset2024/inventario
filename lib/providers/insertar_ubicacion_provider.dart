import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class InsertarUbicacionProvider with ChangeNotifier{

  bool _cargando = false;
  bool get cargando => _cargando;

  Future<void> insertaNuevaUbicacion({
    required String search,
    required String zona,
    required String stand,
    required String col,
    required String fil,
    required String cantidad,
    required String usuario,
    required List<File> imagenes,
    re
  }) async {

    if (zona.isEmpty || stand.isEmpty || col.isEmpty || fil.isEmpty || cantidad.isEmpty){
      
      throw ArgumentError('Complete los campos');
    }


    final url = Uri.parse('http://190.107.181.163:81/amq/flutter_ajax_add.php');
    _cargando = true;
    try{
      var request = http.MultipartRequest('POST', url);
      request.fields['search'] = search;
      request.fields['zona'] = zona;
      request.fields['stand'] = stand;
      request.fields['col'] = col;
      request.fields['fil'] = fil;
      request.fields['cantidad'] = cantidad;  
      request.fields['usuario'] = usuario; 

      print('search: $search');
      print('zona: $zona');
      print('stand: $stand');
      print('col: $col');
      print('fil: $search');
      print('cantidad: $cantidad');
      print('usuario: $usuario');

      for (var imagen in imagenes){
        print('lista-----> : $imagenes');
        request.files.add(await http.MultipartFile.fromPath('img[]', imagen.path, contentType: MediaType('image', 'jpeg')));
      }
      final response = await request.send();

      if(response.statusCode == 200){
        final responseBody = await response.stream.bytesToString();
        if (kDebugMode) {
          print('Respuesta del servidor: $responseBody');
        }
        final responseData = jsonDecode(responseBody);
        if (kDebugMode) {
          print('Datos enviados correctamente: $responseData');
        }
      } else {
        if (kDebugMode) {
          print('Error al enviar datos al servidor: ${response.statusCode}');
        }
      }
    } catch(err){
      if(kDebugMode){
        print('Error: $err');
      }
    }
    _cargando = false;
    notifyListeners();
  }

}
