class BookUnit {
  int id_job;
  String id_exp_spen;
  int id_use_int;
  int secret_class;
  int speed_class;
  String doc_unit_no;
  String unit_date_no;
  String title;
  String doc_unit;
  int years;
  String response_person;
  int status_wd;
  int status_use;
  double amout;
  double amout_rpay;
  String LastAccess;
  String type_job;
  String send;

  BookUnit({
    required this.id_job,
    required this.id_exp_spen,
    required this.id_use_int,
    required this.secret_class,
    required this.speed_class,
    required this.doc_unit_no,
    required this.unit_date_no,
    required this.title,
    required this.doc_unit,
    required this.years,
    required this.response_person,
    this.status_wd = 0,
    this.status_use = 0,
    this.amout = 0.00,
    this.amout_rpay = 0.00,
    required this.LastAccess,
    required this.type_job,
    required this.send,
  });

  @override
  String toString() {
    //return "id_exp_spen=>$id_exp_spen,list_exp_spen=>$list_exp_spen,memo_th=>$memo_th,mborder=>$mborder,malloc=>$malloc";
    return "id_job=>$id_job,id_exp_spen=>$id_exp_spen,id_use_int=>$id_use_int,secret_class=>$secret_class,speed_class=>$speed_class,doc_unit_no=>$doc_unit_no,unit_date_no=>$unit_date_no,title=>$title,doc_unit=>$doc_unit,years=>$years,response_person=>$response_person,status_wd=>$status_wd,status_use=>$status_use,amout=>$amout,amout_rpay=>$amout_rpay,LastAccess=>$LastAccess,type_job=>$type_job,send=$send";
  }

  factory BookUnit.fromJson(Map<String, dynamic> json) {
    return BookUnit(
      id_job: int.parse(json['id_job']),
      id_exp_spen: json['id_exp_spen'],
      id_use_int: int.parse(json['id_use_int']),
      secret_class: int.parse(json['secret_class']),
      speed_class: int.parse(json['speed_class']),
      doc_unit_no: json['doc_unit_no'],
      unit_date_no: json['unit_date_no'],
      title: json['title'],
      doc_unit: (json["doc_unit"] == null) ? "" : json["doc_unit"],
      years: int.parse(json['years']),
      response_person: json['response_person'],
      status_wd: (json["status_wd"] == null) ? 0 : int.parse(json["status_wd"]),
      status_use:
          (json["status_use"] == null) ? 0 : int.parse(json["status_use"]),
      amout: (json["amout"] == null)
          ? 0.00
          : double.parse(json["amout"]), //double.parse(json['amout']),
      amout_rpay:
          (json["amout"] == null) ? 0.00 : double.parse(json["amout_rpay"]),
      LastAccess: json['LastAccess'],
      type_job: json['type_job'],
      send: json['send'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_job': id_job,
        'id_exp_spen': id_exp_spen,
        'id_use_int': id_use_int,
        'secret_class': secret_class,
        'speed_class': speed_class,
        'doc_unit_no': doc_unit_no,
        'unit_date_no': unit_date_no,
        'title': title,
        'doc_unit': doc_unit,
        'years': years,
        'response_person': response_person,
        'status_wd': status_wd,
        'status_use': status_use,
        'amout': amout,
        'amout_rpay': amout_rpay,
        'LastAccess': LastAccess,
        'type_job': type_job,
        'send': send
      };
}
