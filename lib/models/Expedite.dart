class Expedite {
  int idlist;
  String id_exp_spen;
  String list_exp_spen;
  String memo_th;
  int status;
  String daystart;
  String daystop;
  String code_bud_rtarf;
  int field_work;
  int exp_type;
  int int_group;
  int unit_use;
  int unit_oper;
  double mborder;
  int bud_type;
  double malloc;
  double mpay;
  double bpay_n;
  double bpay;
  double cpay;
  double dpay;
  double spay;
  double spay_n;
  double opay;
  double tpay;
  double tlpay;
  double stpay;
  double balan;
  int years;
  double m10;
  double m11;
  double m12;
  double sum1;
  double m01;
  double m02;
  double m03;
  double sum2;
  double m04;
  double m05;
  double m06;
  double sum3;
  double m07;
  double m08;
  double m09;
  double sum4;
  String stwork;
  int whocreate;
  String createtime;
  int whouse;
  String lastaccess;
  String unit_chk;
  String st_rx;
  double st_malloc;

  //Spending(this.aid, this.userid, this.passwords);
  Expedite({
    required this.idlist,
    required this.id_exp_spen,
    required this.list_exp_spen,
    required this.memo_th,
    required this.status,
    required this.daystart,
    required this.daystop,
    required this.code_bud_rtarf,
    required this.field_work,
    required this.exp_type,
    required this.int_group,
    required this.unit_use,
    required this.unit_oper,
    required this.mborder,
    required this.bud_type,
    required this.malloc,
    required this.mpay,
    required this.bpay_n,
    required this.bpay,
    required this.cpay,
    required this.dpay,
    required this.spay,
    required this.spay_n,
    required this.opay,
    required this.tpay,
    required this.tlpay,
    required this.stpay,
    required this.balan,
    required this.years,
    required this.m10,
    required this.m11,
    required this.m12,
    required this.sum1,
    required this.m01,
    required this.m02,
    required this.m03,
    required this.sum2,
    required this.m04,
    required this.m05,
    required this.m06,
    required this.sum3,
    required this.m07,
    required this.m08,
    required this.m09,
    required this.sum4,
    required this.stwork,
    required this.whocreate,
    required this.createtime,
    required this.whouse,
    required this.lastaccess,
    required this.unit_chk,
    required this.st_rx,
    required this.st_malloc,
  });

  @override
  String toString() {
    //return "id_exp_spen=>$id_exp_spen,list_exp_spen=>$list_exp_spen,memo_th=>$memo_th,mborder=>$mborder,malloc=>$malloc";
    return "idlist=>$idlist,id_exp_spen=>$id_exp_spen,list_exp_spen=>$list_exp_spen,memo_th=>$memo_th,status=>$status,daystart=>$daystart,daystop=>$daystop,code_bud_rtarf=>$code_bud_rtarf, field_work=>$field_work, exp_type=>$exp_type, int_group=>$int_group, unit_use=>$unit_use, unit_oper=>$unit_oper, mborder=>$mborder, bud_type=>$bud_type, malloc=>$malloc,mpay=>$mpay,bpay_n=>$bpay_n, bpay=>$bpay, cpay=>$cpay, dpay=>$dpay, spay=>$spay, spay_n=>$spay_n, opay=>$opay, tpay=>$tpay, tlpay=>$tlpay, stpay=>$stpay, balan=>$balan, years=>$years, m10=>$m10, m11=>$m11, m12=>$m12,sum1=>$sum1, m01=>$m01, m02=>$m02, m03=>$m03, sum2=>$sum2, m04=>$m04, m05=>$m05, m06=>$m06, sum3=>$sum3, m07=>$m07, m08=>$m08, m09=>$m09, sum4=>$sum4, stwork=>$stwork, whocreate=>$whocreate, createtime=>$createtime, whouse=>$whouse, lastaccess=>$lastaccess, unit_chk=>$unit_chk, st_rx=>$st_rx, st_malloc=>$st_malloc";
  }

  factory Expedite.fromJson(Map<String, dynamic> json) {
    return Expedite(
      idlist: int.parse(json['idlist']),
      id_exp_spen: json['id_exp_spen'],
      list_exp_spen: json['list_exp_spen'],
      memo_th: json['memo_th'],
      status: (json["status"] == null) ? 0 : int.parse(json['status']),
      daystart: json['daystart'] ?? '0000-00-00',
      daystop: json['daystop'] ?? '0000-00-00',
      code_bud_rtarf: json['code_bud_rtarf'] ?? '',
      field_work:
          (json["field_work"] == null) ? 0 : int.parse(json["field_work"]),
      exp_type: (json["exp_type"] == null) ? 0 : int.parse(json["exp_type"]),
      int_group: (json["int_group"] == null) ? 0 : int.parse(json["int_group"]),
      unit_use: (json["unit_use"] == null) ? 0 : int.parse(json["unit_use"]),
      unit_oper: (json["unit_oper"] == null) ? 0 : int.parse(json["unit_oper"]),
      mborder: (json["mborder"] == null) ? 0.00 : double.parse(json["mborder"]),
      bud_type: int.parse(json['bud_type'] ?? 0),
      malloc: double.parse(json['malloc'] ?? 0.00),
      mpay: double.parse(json['mpay'] ?? 0.00),
      bpay_n: double.parse(json['bpay_n'] ?? 0.00),
      bpay: double.parse(json['bpay'] ?? 0.00),
      cpay: double.parse(json['cpay'] ?? 0.00),
      dpay: double.parse(json['dpay'] ?? 0.00),
      spay: double.parse(json['spay'] ?? 0.00),
      spay_n: double.parse(json['spay_n'] ?? 0.00),
      opay: double.parse(json['opay'] ?? 0.00),
      tpay: double.parse(json['tpay'] ?? 0.00),
      tlpay: double.parse(json['tlpay'] ?? 0.00),
      stpay: double.parse(json['stpay'] ?? 0.00),
      balan: double.parse(json['balan'] ?? 0.00),
      years: int.parse(json['years'] ?? 0),
      m10: double.parse(json['m10'] ?? 0.00),
      m11: double.parse(json['m11'] ?? 0.00),
      m12: double.parse(json['m12'] ?? 0.00),
      sum1: double.parse(json['sum1'] ?? 0.00),
      m01: double.parse(json['m01'] ?? 0.00),
      m02: double.parse(json['m02'] ?? 0.00),
      m03: double.parse(json['m03'] ?? 0.00),
      sum2: double.parse(json['sum2'] ?? 0.00),
      m04: double.parse(json['m04'] ?? 0.00),
      m05: double.parse(json['m05'] ?? 0.00),
      m06: double.parse(json['m06'] ?? 0.00),
      sum3: double.parse(json['sum3'] ?? 0.00),
      m07: double.parse(json['m07'] ?? 0.00),
      m08: double.parse(json['m08'] ?? 0.00),
      m09: double.parse(json['m09'] ?? 0.00),
      sum4: double.parse(json['sum4'] ?? 0.00),
      stwork: json['stwork'] ?? '',
      whocreate: (json['whocreate'] == null) ? 0 : int.parse(json["whocreate"]),
      createtime: json['createtime'] ?? '0000-00-00',
      whouse: (json['whouse'] == null) ? 0 : int.parse(json["whouse"]),
      lastaccess: json['lastaccess'] ?? '0000-00-00',
      unit_chk: json['unit_chk'] ?? '',
      st_rx: json['st_rx'] ?? '',
      st_malloc: double.parse(json['st_malloc'] ?? 0.00),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'idlist': idlist,
        'id_exp_spen': id_exp_spen,
        'list_exp_spen': list_exp_spen,
        'memo_th': memo_th,
        'status': status,
        'daystart': daystart,
        'daystop': daystop,
        'code_bud_rtarf': code_bud_rtarf,
        'field_work': field_work,
        'exp_type': exp_type,
        'int_group': int_group,
        'unit_use': unit_use,
        'unit_oper': unit_oper,
        'mborder': mborder,
        'bud_type': bud_type,
        'malloc': malloc,
        'mpay': mpay,
        'bpay_n': bpay_n,
        'bpay': bpay,
        'cpay': cpay,
        'dpay': dpay,
        'spay': spay,
        'spay_n': spay_n,
        'opay': opay,
        'tpay': tpay,
        'tlpay': tlpay,
        'stpay': stpay,
        'balan': balan,
        'years': years,
        'm10': m10,
        'm11': m11,
        'm12': m12,
        'sum1': sum1,
        'm01': m01,
        'm02': m02,
        'm03': m03,
        'sum2': sum2,
        'm04': m04,
        'm05': m05,
        'm06': m06,
        'sum3': sum3,
        'm07': m07,
        'm08': m08,
        'm09': m09,
        'sum4': sum4,
        'stwork': stwork,
        'whocreate': whocreate,
        'createtime': createtime,
        'whouse': whouse,
        'lastaccess': lastaccess,
        'unit_chk': unit_chk,
        'st_rx': st_rx,
        'st_malloc': st_malloc,
      };
}
