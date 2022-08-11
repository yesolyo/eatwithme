class StoreAll {
  final int Latitude;
  final int Longitude;
  final String address;
  final String category;
  final String number;
  final int store_id;
  final String store_name;

  StoreAll({
    required this.Latitude,
    required this.Longitude,
    required this.address,
    required this.category,
    required this.number,
    required this.store_name,
    required this.store_id,
  });

  Map<String, dynamic> toJson() =>
      {
        'Latitude': Latitude,
        'Longitude': Longitude,
        'address': address,
        'category': category,
        'number': number,
        'store_name': store_name,
        'store_id': store_id,};

  static StoreAll fromJson(Map<String, dynamic> json) => StoreAll(
      Latitude: json['Latitude'],
      Longitude: json['Longitude'],
      address: json['address'],
      category: json['category'],
      number: json['number'],
      store_name: json['store_name'],
      store_id: json['store_id'],
  );
}

