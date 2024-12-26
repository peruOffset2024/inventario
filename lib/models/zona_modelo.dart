// To parse this JSON data, do
//
//     final zona = zonaFromJson(jsonString);

import 'dart:convert';

List<Zona> zonaFromJson(String str) => List<Zona>.from(json.decode(str).map((x) => Zona.fromJson(x)));

String zonaToJson(List<Zona> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Zona {
    String id;
    String descripcion;

    Zona({
        required this.id,
        required this.descripcion,
    });

    factory Zona.fromJson(Map<String, dynamic> json) => Zona(
        id: json["id"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
    };
}
