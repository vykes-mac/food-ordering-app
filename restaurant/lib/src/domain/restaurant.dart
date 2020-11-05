import 'package:equatable/equatable.dart';
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

class Location extends Equatable {
  final double longitude;
  final double latitude;

  Location({
    @required this.longitude,
    @required this.latitude,
  });

  @override
  List<Object> get props => [longitude, latitude];
}

class Address extends Equatable {
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

  @override
  List<Object> get props => [street, city, parish, zone];
}
