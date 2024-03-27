class TBStatusSearch {
  String years;
  int id_status;
  int id_job;
  int id_use_int;
  int sent_to;
  String date_sent_to;
  String date_sent_real;
  String date_receive_real;
  String status_work;
  String status_detail;
  String list_exp_spen;
  String title;
  String unit_send_name;
  String amout;
  String doc_unit_no;
  String doc_unit;
  String no_doc_rx;
  String date_rec_rx;
  String date_sent;
  String etc;
  bool status_bpay;
  String date_check;
  String response_person;

  TBStatusSearch({
    required this.years,
    required this.id_status,
    required this.id_job,
    required this.id_use_int,
    required this.sent_to,
    required this.date_sent_to,
    required this.date_sent_real,
    required this.date_receive_real,
    required this.status_work,
    required this.status_detail,
    required this.list_exp_spen,
    required this.title,
    required this.unit_send_name,
    required this.amout,
    required this.doc_unit_no,
    required this.doc_unit,
    required this.no_doc_rx,
    required this.date_rec_rx,
    required this.date_sent,
    required this.etc,
    required this.status_bpay,
    required this.date_check,
    required this.response_person,
  });

  @override
  String toString() {
    //return "id_exp_spen=>$id_exp_spen,list_exp_spen=>$list_exp_spen,memo_th=>$memo_th,mborder=>$mborder,malloc=>$malloc";
    return "years=>$years,id_status=>$id_status,id_job=>$id_job,id_use_int=>$id_use_int,sent_to=>$sent_to,date_sent_to=>$date_sent_to,date_sent_real=>$date_sent_real,date_receive_real=>$date_receive_real,status_work=>$status_work,status_detail=>$status_detail,list_exp_spen: $list_exp_spen,title=>$title,unit_send_name=>$unit_send_name,amout=>$amout,doc_unit_no=>$doc_unit_no,doc_unit=>$doc_unit,no_doc_rx=>$no_doc_rx,date_rec_rx=>$date_rec_rx,date_sent=>$date_sent,etc=>$etc,status_bpay=>$status_bpay,date_check=>$date_check,response_person=>$response_person";
  }

  factory TBStatusSearch.fromJson(Map<String, dynamic> json) {
    return TBStatusSearch(
      years: json['years'],
      id_status: int.parse(json['id_status']),
      id_job: int.parse(json['id_job']),
      id_use_int: int.parse(json['id_use_int']),
      sent_to: int.parse(json['sent_to']),
      date_sent_to: json['date_sent_to'] ?? '',
      date_sent_real: json['date_sent_real'] ?? '',
      date_receive_real: json['date_receive_real'] ?? '',
      status_work: json['status_work'] ?? '',
      status_detail: json['status_detail'] ?? '',
      list_exp_spen: json['list_exp_spen'] ?? '',
      title: json['title'] ?? '',
      unit_send_name: json['unit_send_name'] ?? '',
      amout: json['amout'] ?? '0',
      doc_unit_no: json['doc_unit_no'] ?? '',
      doc_unit: json['doc_unit'] ?? '',
      no_doc_rx: json['no_doc_rx'] ?? '',
      date_rec_rx: json['date_rec_rx'] ?? '',
      date_sent: json['date_sent'] ?? '',
      etc: json['etc'] ?? '',
      status_bpay: (json["status_bpay"] == 1) ? true : false,
      date_check: json['date_check'] ?? '',
      response_person: json['response_person'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'years': years,
        'id_status': id_status,
        'id_job': id_job,
        'id_use_int': id_use_int,
        'sent_to': sent_to,
        'date_sent_to': date_sent_to,
        'date_sent_real': date_sent_real,
        'date_receive_real': date_receive_real,
        'status_work': status_work,
        'status_detail': status_detail,
        'list_exp_spen': list_exp_spen,
        'title': title,
        'unit_send_name': unit_send_name,
        'amout': amout,
        'doc_unit_no': doc_unit_no,
        'doc_unit': doc_unit,
        'no_doc_rx': no_doc_rx,
        'date_rec_rx': date_rec_rx,
        'date_sent': date_sent,
        'etc': etc,
        'status_bpay': status_bpay,
        'date_check': date_check,
        'response_person': response_person,
      };
}
