// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  int oid;
  int uid;
  double sumPrice;
  double discountPro;
 double discountMember;
  double netPrice;
  String orderStatus;
  String dateTime;

  Orders({
    required this.oid,
    required this.uid,
    required this.sumPrice,
    required this.discountPro,
    required this.discountMember,
    required this.netPrice,
    required this.orderStatus,
    required this.dateTime,
  });

  @override
  String toString() {
    return "oid=>$oid,uid=>$uid,sumPrice=>$sumPrice,discountPro=>$discountPro,discountMember=>$discountMember,netPrice=>$netPrice,orderStatus=>$orderStatus,dateTime=>$dateTime";
  }

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        oid: json["oid"],
        uid: json["uid"],
        sumPrice: json["sum_price"],
        discountPro: json["discount_pro"],
        discountMember: json["discount_member"],
        netPrice: json["net_price"],
        orderStatus: json["order_status"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "oid": oid,
        "uid": uid,
        "sum_price": sumPrice,
        "discount_pro": discountPro,
        "discount_member": discountMember,
        "net_price": netPrice,
        "order_status": orderStatus,
        "date_time": dateTime,
      };
}
