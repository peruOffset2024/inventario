// To parse this JSON data, do
//
//     final consultaStock = consultaStockFromJson(jsonString);

import 'dart:convert';

List<ConsultaStock> consultaStockFromJson(String str) =>
    List<ConsultaStock>.from(
        json.decode(str).map((x) => ConsultaStock.fromJson(x)));

String consultaStockToJson(List<ConsultaStock> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsultaStock {
  String compania;
  String item;
  String estado;
  String name;
  String itemCode;
  String stock;
  String linea;
  String familia;
  String subfamilia;
  String itemdescripcion;
  String pesoGramaje;
  dynamic volumenCalibre;
  String largo;
  String ancho;
  String marca;
  String unit;

  ConsultaStock({
    required this.compania,
    required this.item,
    required this.estado,
    required this.name,
    required this.itemCode,
    required this.stock,
    required this.linea,
    required this.familia,
    required this.subfamilia,
    required this.itemdescripcion,
    required this.pesoGramaje,
    required this.volumenCalibre,
    required this.largo,
    required this.ancho,
    required this.marca,
    required this.unit,
  });

  factory ConsultaStock.fromJson(Map<String, dynamic> json) => ConsultaStock(
        compania: json["compañia"] ?? "",
        item: json["item"] ?? "",
        estado: json["estado"] ?? "",
        name: json["Name"] ?? "",
        itemCode: json["ItemCode"] ?? "",
        stock: json["Stock"] ?? "",
        linea: json["linea"] ?? "",
        familia: json["familia"] ?? "",
        subfamilia: json["subfamilia"] ?? "",
        itemdescripcion: json["itemdescripcion"] ?? "",
        pesoGramaje: json["PESO(GRAMAJE)"] ?? "",
        volumenCalibre: json["VOLUMEN(CALIBRE)"] ?? "",
        largo: json["largo"] ?? "",
        ancho: json["ancho"] ?? "",
        marca: json["marca"] ?? "",
        unit: json["Unit"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "compañia": compania,
        "item": item,
        "estado": estado,
        "Name": name,
        "ItemCode": itemCode,
        "Stock": stock,
        "linea": linea,
        "familia": familia,
        "subfamilia": subfamilia,
        "itemdescripcion": itemdescripcion,
        "PESO(GRAMAJE)": pesoGramaje,
        "VOLUMEN(CALIBRE)": volumenCalibre,
        "largo": largo,
        "ancho": ancho,
        "marca": marca,
        "Unit": unit,
      };
}
