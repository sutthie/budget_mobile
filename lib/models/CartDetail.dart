// To parse this JSON data, do
//
//     final cartDetail = cartDetailFromJson(jsonString);

import 'dart:convert';

CartDetail cartDetailFromJson(String str) =>
    CartDetail.fromJson(json.decode(str));

String cartDetailToJson(CartDetail data) => json.encode(data.toJson());

class CartDetail {
  CartDetail({
    required this.cidDetail,
    required this.cid,
    required this.pid,
    required this.price,
    required this.cnt,
    required this.proPrice,
    required this.discountstr,
    required this.sumPrice,
  });

  String cidDetail;
  String cid;
  String pid;
  String price;
  String cnt;
  String proPrice;
  String discountstr;
  String sumPrice;

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
        cidDetail: json["cid_detail"],
        cid: json["cid"],
        pid: json["pid"],
        price: json["price"],
        cnt: json["cnt"],
        proPrice: json["pro_price"],
        discountstr: json["discountstr"],
        sumPrice: json["sum_price"],
      );

  Map<String, dynamic> toJson() => {
        "cid_detail": cidDetail,
        "cid": cid,
        "pid": pid,
        "price": price,
        "cnt": cnt,
        "pro_price": proPrice,
        "discountstr": discountstr,
        "sum_price": sumPrice,
      };
}
