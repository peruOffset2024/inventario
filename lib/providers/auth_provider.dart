import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AuthProvider with ChangeNotifier{
  bool _isAuthenticated = false;
  String _user = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _user;

  Future<void> authenticate(String uss, String pass) async {
    try{
      login(uss, pass);
      
    } catch(err){
      print('Error: $err');
    }
  }

  Future<void> login(String usuario, String password) async {
    
    try{
      final response = await http.get(Uri.parse('http://190.107.181.163:81/amq/flutter_ajax_token.php?uss=$usuario&pass=$password'));
      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        if(responseBody['valid'] == true) {
          _user = responseBody['usuario'] ?? '';
          _isAuthenticated = true;
          
          print('Respuesta de la api: $responseBody');
          print('response de la api: $response');
          print('response.statusCode de la api: ${response.statusCode}');
          notifyListeners();
        } else {
          _isAuthenticated = false;
          _user = '';
          notifyListeners();
          throw Exception(responseBody['message'] ?? 'Authentication failed');
        }
      } else {
        _isAuthenticated = false;
        _user = '';
        notifyListeners();
        throw Exception('Failed to Authenticate');
      }
    }catch(e){
      _isAuthenticated = false;
        _user = '';
        // ignore: avoid_print
        print('Error: $e');
        notifyListeners();

    }
  }

  void logout(){
    _isAuthenticated = false;
    _user = '';
    notifyListeners();
  }

}