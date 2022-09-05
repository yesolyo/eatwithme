class Matching {
  String id;
  final String date;
  final String start;
  final String end;
  final String title;
  final String detail;
  final int max;
  final String storeName;
  final String register_id;
  final String user_id;

  Matching({
    this.id = '',
    required this.date,
    required this.start,
    required this.end,
    required this.title,
    required this.detail,
    required this.max,
    required this.storeName,
    required this.register_id,
    required this.user_id,
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'date': date,
        'start': start,
        'end': end,
        'title': title,
        'detail': detail,
        'max': max,
        'storeName': storeName,
        'register_id': register_id,
        'user_id': user_id};

  static Matching fromJson(Map<String, dynamic> json) => Matching(
      id: json['id'],
    date: json['date'],
    start: json['start'],
    end: json['end'],
    title: json['title'],
    detail: json['detail'],
      max: json['max'],
    storeName: json['storeName'],
    register_id: json['register_id'],
      user_id: json['user_id']);
}

