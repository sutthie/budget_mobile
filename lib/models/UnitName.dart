class UnitName {
  String uint;
  String uint_name;

  //Account(this.aid, this.userid, this.passwords);
  UnitName({
    required this.uint,
    required this.uint_name,
  });

  @override
  String toString() {
    return "uint=>$uint,uint_name=>$uint_name";
  }

  factory UnitName.fromJson(Map<String, dynamic> json) {
    // be carefully  json['FieldName']  FieldName name same in Database
    return UnitName(uint: json['Uint'], uint_name: json['Uint_Name']);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'uint': uint, 'uint_name': uint_name};
}
