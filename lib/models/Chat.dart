class Chat {
  String socketid;
  String username;
  String message;
  String room;
  String datetimes;

  Chat({
    required this.socketid,
    required this.username,
    required this.message,
    required this.room,
    required this.datetimes,
  });

  @override
  String toString() {
    return "socketid=>$socketid,username=>$username,message=>$message,room=>$room,datetimes=>$datetimes";
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      socketid: json['socketid'],
      username: json['username'],
      message: json['message'],
      room: json['room'],
      datetimes: json['datetimes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'socketid': socketid,
        'username': username,
        'message': message,
        'room': room,
        'datetimes': datetimes,
      };
}
