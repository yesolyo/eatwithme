class Register {
  String id;
  final String date;
  final int min;
  final int max;
  final String start;
  final String end;
  final String title;
  final String detail;
  final int approve;
  final String storeName;
  final String user_id;

  Register({
    this.id = '',
    required this.date,
    required this.min,
    required this.max,
    required this.start,
    required this.end,
    required this.title,
    required this.detail,
    required this.approve,
    required this.storeName,
    required this.user_id,});

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'date': date,
        'min': min,
        'max': max,
        'start': start,
        'end': end,
        'title': title,
        'detail': detail,
        'approve': approve,
        'storeName': storeName,
        'user_id': user_id};

  static Register fromJson(Map<String, dynamic> json) => Register(
      id: json['id'],
      date: json['date'],
      min: json['min'],
      max: json['max'],
      start: json['start'],
      end: json['end'],
      title: json['title'],
      detail: json['detail'],
      approve: json['approve'],
      storeName: json['storeName'],
      user_id: json['user_id'],);
}

