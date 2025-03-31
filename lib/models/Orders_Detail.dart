// To parse this JSON data, do
//
//     final ordersDetail = ordersDetailFromJson(jsonString);

import 'dart:convert';

OrdersDetail ordersDetailFromJson(String str) =>
    OrdersDetail.fromJson(json.decode(str));

String ordersDetailToJson(OrdersDetail data) => json.encode(data.toJson());

class OrdersDetail {
  int oidDetail;
  int oid;
  int pid;
  double price;
  int cnt;
  double proPrice;
  String discountstr;
  double sumPrice;
  int orderStatusDetail;

  OrdersDetail({
    required this.oidDetail,
    required this.oid,
    required this.pid,
    required this.price,
    required this.cnt,
    required this.proPrice,
    required this.discountstr,
    required this.sumPrice,
    required this.orderStatusDetail,
  });

  @override
  String toString() {
    return "oidDetail=>$oidDetail,oid=>$oid,pid=>$pid,price=>$price,cnt=>$cnt,proPrice=>$proPrice,discountstr=>$discountstr,sumPrice=>$sumPrice,orderStatusDetail=>$orderStatusDetail";
  }

  factory OrdersDetail.fromJson(Map<String, dynamic> json) => OrdersDetail(
        oidDetail: json["oid_detail"],
        oid: json["oid"],
        pid: json["pid"],
        price: json["price"],
        cnt: json["cnt"],
        proPrice: json["pro_price"],
        discountstr: json["discountstr"],
        sumPrice: json["sum_price"],
        orderStatusDetail: json["order_status_detail"],
      );

  Map<String, dynamic> toJson() => {
        "oid_detail": oidDetail,
        "oid": oid,
        "pid": pid,
        "price": price,
        "cnt": cnt,
        "pro_price": proPrice,
        "discountstr": discountstr,
        "sum_price": sumPrice,
        "order_status_detail": orderStatusDetail,
      };
}
