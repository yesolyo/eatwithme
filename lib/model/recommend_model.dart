class Rec {
  String id;
  final int rating;
  final int store_id;
  final String user_id;


  Rec({
    this.id = '',
    required this.rating,
    required this.store_id,
    required this.user_id,});

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'rating': rating,
        'store_id': store_id,
        'user_id': user_id,
        };

  static Rec fromJson(Map<String, dynamic> json) => Rec(
      rating: json['rating'],
      store_id: json['store_id'],
      user_id: json['user_id'],);
}
