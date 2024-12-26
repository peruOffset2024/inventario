import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImagenesProvider with ChangeNotifier{
  final ImagePicker _picker = ImagePicker();
  List<File> _imagenes = [];
  bool _cargando = false;

  List<File> get imagenes => _imagenes;
  bool get cargando => _cargando;

  Future<void> imagenesDeGaleria() async {
    _cargando = true;

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if(pickedFiles != null && pickedFiles.isNotEmpty){
      List<File> compressedImages = [];
      for (var file in pickedFiles){
        File compressedFile = await _compressImage(File(file.path));
        compressedImages.add(compressedFile);
      }
      _imagenes.addAll(compressedImages);
      notifyListeners();
    }
    _cargando = false;
  }

  Future<void> tomarFoto() async {
    _cargando = true;
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if(pickedFile != null){
      File compressedFile = await _compressImage(File(pickedFile.path));
      _imagenes.add(compressedFile);
      notifyListeners();
    }
    _cargando = false;
  }

  //metodo para comprimir la imagen
  Future<File> _compressImage(File imageFile)async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);

    if(image == null ){
      throw Exception("No se puede decodificar la imagen");
    }

    // Calcular las nuevas dimensiones reduciendo el 20%
    final int newWidth = (image.width * 0.8).toInt();
    final int newHeight = (image.height * 0.8).toInt();

    // Redimensionar la imagen
    final resized = img.copyResize(image, width: newWidth, height: newHeight);

    // Comprimir la imagen con calidad 85 (puedes ajustar la calidad si es necesario)
    final compressedBytes = img.encodeJpg(resized, quality: 85);

    // Escribir la imagen comprimida a un nuevo archivo
    final compressedFile = File(imageFile.path)..writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  void eliminarImagen(File image){
    _imagenes.remove(image);
    notifyListeners();
  }

  void limpiarImagenes() {
    _imagenes.clear();
    notifyListeners();
  }

}