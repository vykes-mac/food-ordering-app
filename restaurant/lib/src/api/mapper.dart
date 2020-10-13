import '../domain/restaurant.dart';

class Mapper {
  static fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      displayImgUrl: json['image_url'] ?? '',
      location: Location(
        latitude: json['location']['latitude'],
        longitude: json['location']['longitude'],
      ),
      address: Address(
        street: json['address']['street'],
        city: json['address']['city'],
        parish: json['address']['parish'],
        zone: json['address']['zone'] ?? '',
      ),
    );
  }
}
