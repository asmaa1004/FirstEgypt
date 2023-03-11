// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'dart:convert';

Customers customersFromJson(String str) => Customers.fromJson(json.decode(str));

String customersToJson(Customers data) => json.encode(data.toJson());

class Customers {
  Customers({
    required this.status,
    required this.data,
  });

  String status;
  List<Data> data;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
    status: json["status"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    required this.cusCode,
    required this.cusName,
  });

  String cusCode;
  String cusName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cusCode: json["CusCode"],
    cusName: json["CusName"],
  );

  Map<String, dynamic> toJson() => {
    "CusCode": cusCode,
    "CusName": cusName,
  };
}
