// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Carts cartFromJson(String str) => Carts.fromJson(json.decode(str));

String cartToJson(Carts data) => json.encode(data.toJson());

class Carts {
  Carts({
    required this.cid,
    required this.uid,
    required this.sumPrice,
    required this.discountPro,
    required this.discountMember,
    required this.netPrice,
  });

  int cid;
  int uid;
  double sumPrice;
  double discountPro;
  double discountMember;
  double netPrice;

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
        cid: json["cid"],
        uid: json["uid"],
        sumPrice: json["sum_price"],
        discountPro: json["discount_pro"],
        discountMember: json["discount_member"],
        netPrice: json["net_price"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "uid": uid,
        "sum_price": sumPrice,
        "discount_pro": discountPro,
        "discount_member": discountMember,
        "net_price": netPrice,
      };
}
