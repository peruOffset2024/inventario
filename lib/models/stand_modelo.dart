// To parse this JSON data, do
//
//     final stand = standFromJson(jsonString);

import 'dart:convert';

List<Stand> standFromJson(String str) => List<Stand>.from(json.decode(str).map((x) => Stand.fromJson(x)));

String standToJson(List<Stand> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stand {
    String id;
    String descripcion;

    Stand({
        required this.id,
        required this.descripcion,
    });

    factory Stand.fromJson(Map<String, dynamic> json) => Stand(
        id: json["id"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
    };
}
