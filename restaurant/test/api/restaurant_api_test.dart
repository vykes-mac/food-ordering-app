import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant/src/api/restaurant_api.dart';

class HttpClient extends Mock implements http.Client {}

void main() {
  RestaurantApi sut;
  HttpClient client;

  setUp(() {
    client = HttpClient();
    sut = RestaurantApi('baseUrl', client);
  });

  group('getAllRestaurants', () {
    test('resturns an empty list when no restaurants are found', () async {
      //arrange
      when(client.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode({"restaurants": []}), 200));
      //act
      final results = await sut.getAllRestaurants(page: 1);

      //assert
      expect(results, []);
    });
    test('resturns an empty list when response status is not 200', () async {
      //arrange
      when(client.get(any))
          .thenAnswer((_) async => http.Response(jsonEncode({}), 401));
      //act
      final results = await sut.getAllRestaurants(page: 1);

      //assert
      expect(results, []);
    });
    test('resturns list of restaurants when success', () async {
      //arrange
      when(client.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({"restaurants": _restaurantsJson()}), 200));
      //act
      final results = await sut.getAllRestaurants(page: 1);

      //assert
      expect(results, isNotEmpty);
    });
  });
}

_restaurantsJson() {
  return [
    {
      "id": "12345",
      "name": "Restuarant Name",
      "type": "Fast Food",
      "image_url": "restaurant.jpg",
      "location": {"longitude": 345.33, "latitude": 345.23},
      "address": {
        "street": "Road 1",
        "city": "City",
        "parish": "Parish",
        "zone": "Zone"
      }
    },
    {
      "id": "12666",
      "name": "Restuarant Name",
      "type": "Fast Food",
      "imageUrl": "restaurant.jpg",
      "location": {"longitude": 345.33, "latitude": 345.23},
      "address": {
        "street": "Road 1",
        "city": "City",
        "parish": "Parish",
        "zone": "Zone"
      }
    }
  ];
}
