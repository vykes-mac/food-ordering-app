import 'package:flutter/foundation.dart';

class Restaurant {
  final String id;
  final String name;
  final String displayImgUrl;
  final String type;
  final Location location;
  final Address address;

  Restaurant({
    @required this.id,
    @required this.name,
    @required this.displayImgUrl,
    @required this.type,
    @required this.location,
    @required this.address,
  });
}

class Location {
  final double longitude;
  final double latitude;

  Location({
    @required this.longitude,
    @required this.latitude,
  });
}

class Address {
  final String street;
  final String city;
  final String parish;
  final String zone;

  Address({
    @required this.street,
    @required this.city,
    @required this.parish,
    this.zone,
  });
}
