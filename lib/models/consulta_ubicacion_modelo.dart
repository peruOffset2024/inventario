import 'dart:convert';

class ConsultaUbicacion {
  String id;
  String zona;
  String stand;
  String col;
  String fil;
  String cantidad;
  List<String>? imgs; // Lista de URLs

  ConsultaUbicacion({
    required this.id,
    required this.zona,
    required this.stand,
    required this.col,
    required this.fil,
    required this.cantidad,
    this.imgs,
  });

  factory ConsultaUbicacion.fromJson(Map<String, dynamic> json) {
    List<String>? imagesList;

    if (json["Img"] != null && json["Img"].isNotEmpty) {
      try {
        List<dynamic> rawImgList = jsonDecode(json["Img"]);
        imagesList = rawImgList.cast<String>();
      } catch (e) {
        print("Error al procesar las imágenes: $e");
      }
    }

    return ConsultaUbicacion(
      id: json["id"] ?? '',
      zona: json["Zona"] ?? '',
      stand: json["Stand"] ?? '',
      col: json["col"] ?? '',
      fil: json["fil"] ?? '',
      cantidad: json["Cantidad"] ?? '',
      imgs: imagesList,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "Zona": zona,
        "Stand": stand,
        "col": col,
        "fil": fil,
        "Cantidad": cantidad,
        "Img": imgs != null ? jsonEncode(imgs) : null,
      };
}
