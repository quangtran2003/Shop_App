// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String? image;
  String? name;
  int? price;
  int? sale;
  int? number;
  String? id;

  ProductModel({
    this.image,
    this.name,
    this.price,
    this.sale,
    this.number,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        image: json["image"],
        name: json["name"],
        price: json["price"],
        sale: json["sale"],
        number: json["number"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "price": price,
        "sale": sale,
        'number': number,
        "id": id,
      };
}
