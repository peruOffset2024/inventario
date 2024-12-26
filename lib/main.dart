import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla/app/app.dart';
import 'package:tesla/providers/auth_provider.dart';
import 'package:tesla/providers/diferencias_provider.dart';
import 'package:tesla/providers/imagenes_provider.dart';
import 'package:tesla/providers/insertar_ubicacion_provider.dart';
import 'package:tesla/providers/stock_provider.dart';
import 'package:tesla/providers/tabla_apuntes_provider.dart';
import 'package:tesla/providers/zona_stand_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AuthProvider(),), 
    ChangeNotifierProvider(create: (_) => ItemConDiferenciasProvider()),
    ChangeNotifierProvider(create: (_) => StockProvider()), 
    ChangeNotifierProvider(create: (_) => ImagenesProvider()), 
    ChangeNotifierProvider(create: (_) => SignatureProvider()), 
    ChangeNotifierProvider(create: (_) => ZonaProvider()), 
    ChangeNotifierProvider(create: (_) => StandProvider()),  
    ChangeNotifierProvider(create: (_) => InsertarUbicacionProvider()), 
    
  ],
  child: const MyApp()));
}



