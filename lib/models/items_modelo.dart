// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

List<Items> itemsFromJson(String str) => List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
    String itemCode;
    String descripcion;
    String diferencia;

    Items({
        required this.itemCode,
        required this.descripcion,
        required this.diferencia,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        itemCode: json["ItemCode"] ?? '',
        descripcion: json["Descripcion"]?? '',
        diferencia: json["diferencia"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "ItemCode": itemCode,
        "Descripcion": descripcion,
        "diferencia": diferencia,
    };
}
