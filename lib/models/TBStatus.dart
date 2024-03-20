class TBStatus {
  int id_status;
  int id_job;
  int id_use_int;
  int sent_to;
  DateTime date_sent_to;
  DateTime date_sent_real;
  DateTime date_receive_real;
  String status;
  String status_detail;
  String doc_unit;
  String no_doc_rx;
  DateTime date_rec_rx;
  DateTime date_sent;
  String etc;
  bool status_bpay;
  DateTime date_check;

  TBStatus({
    required this.id_status,
    required this.id_job,
    required this.id_use_int,
    required this.sent_to,
    required this.date_sent_to,
    required this.date_sent_real,
    required this.date_receive_real,
    required this.status,
    required this.status_detail,
    required this.doc_unit,
    required this.no_doc_rx,
    required this.date_rec_rx,
    required this.date_sent,
    required this.etc,
    required this.status_bpay,
    required this.date_check,
  });

  @override
  String toString() {
    //return "id_exp_spen=>$id_exp_spen,list_exp_spen=>$list_exp_spen,memo_th=>$memo_th,mborder=>$mborder,malloc=>$malloc";
    return "id_status=>$id_status,id_job=>$id_job,id_use_int    =>$id_use_int,sent_to=>$sent_to,date_sent_to=>$date_sent_to,date_sent_real=>$date_sent_real,date_receive_real=>$date_receive_real,status=>$status,status_detail=>$status_detail,doc_unit=>$doc_unit,no_doc_rx=>$no_doc_rx,date_rec_rx=>$date_rec_rx,date_sent=>$date_sent,etc=>$etc,status_bpay=>$status_bpay,date_check=>$date_check";
  }

  factory TBStatus.fromJson(Map<String, dynamic> json) {
    return TBStatus(
      id_status: json['id_status'],
      id_job: json['id_job'],
      id_use_int: json['id_use_int'],
      sent_to: json['sent_to'],
      date_sent_to: json['date_sent_to'],
      date_sent_real: json['date_sent_real'],
      date_receive_real: json['date_receive_real'],
      status: json['status'],
      status_detail: json['status_detail'],
      doc_unit: json['doc_unit'],
      no_doc_rx: json['no_doc_rx'],
      date_rec_rx: json['date_rec_rx'],
      date_sent: json['date_sent'],
      etc: json['etc'],
      status_bpay: json['status_bpay'],
      date_check: json['date_check'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_status': id_status,
        'id_job': id_job,
        'id_use_int': id_use_int,
        'sent_to': sent_to,
        'date_sent_to': date_sent_to,
        'date_sent_real': date_sent_real,
        'date_receive_real': date_receive_real,
        'status': status,
        'status_detail': status_detail,
        'doc_unit': doc_unit,
        'no_doc_rx': no_doc_rx,
        'date_rec_rx': date_rec_rx,
        'date_sent': date_sent,
        'etc': etc,
        'status_bpay': status_bpay,
        'date_check': date_check,
      };
}
