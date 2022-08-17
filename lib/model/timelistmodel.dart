class RecData {
  final String user_id;

  RecData({
    required this.user_id});

  Map<String, dynamic> toJson() =>
      {
        'user_id': user_id};

  static RecData fromJson(Map<String, dynamic> json) => RecData(
    user_id: json['user_id']);
}