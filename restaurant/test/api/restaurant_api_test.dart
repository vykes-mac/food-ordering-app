import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant/src/api/restaurant_api.dart';
import 'package:restaurant/src/domain/restaurant.dart';

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

  group('getRestaurant', () {
    test('returns null when the restaurant is not foun d', () async {
      when(client.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({"error": "restaurant not found"}), 404));

      final result = await sut.getRestaurant(id: '12334');

      expect(result, null);
    });
    test('returns restaurant when success', () async {
      //arrange
      when(client.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode(_restaurantsJson()[0]), 200));

      //act
      final result = await sut.getRestaurant(id: '12345');

      //assert
      expect(result, isNotNull);
      expect(result.id, '12345');
    });
  });

  group('getRestaurantsByLocation', () {
    test('returns an empty list when no restaurants are found', () async {
      //arrange
      when(client.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode({"restaurants": []}), 200));
      //act
      final results = await sut.getRestaurantByLocation(
        page: 1,
        location: Location(longitude: 1233, latitude: 12.45),
      );

      //assert
      expect(results, []);
    });

    test('returns list of restaurants when success', () async {
      //arrange
      when(client.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({"restaurants": _restaurantsJson()}), 200));
      //act
      final results = await sut.getRestaurantByLocation(
        page: 1,
        location: Location(longitude: 1233, latitude: 12.45),
      );
      //assert
      expect(results, isNotEmpty);
      expect(results.length, 2);
    });
  });
  group('findRestaurants', () {
    test('returns an empty list when no restaurants are found', () async {
      //arrange
      when(client.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode({"restaurants": []}), 200));
      //act
      final results = await sut.findRestaurants(page: 1, searchTerm: 'blaggg');

      //assert
      expect(results, []);
    });

    test('returns list of restaurants when success', () async {
      //arrange
      when(client.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({"restaurants": _restaurantsJson()}), 200));
      //act
      final results = await sut.findRestaurants(page: 1, searchTerm: 'blaaas');
      //assert
      expect(results, isNotEmpty);
      expect(results.length, 2);
    });
  });

  group('getRestaurantMenu', () {
    test('returns empty list when no menu is found', () async {
      when(client.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode({"menu": []}), 404));

      final result = await sut.getRestaurantMenu(restaurantId: '12345');

      expect(result, []);
    });

    test('returns restaurant menu when success', () async {
      when(client.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({"menu": _restaurantMenuJson()}), 200));

      final result = await sut.getRestaurantMenu(restaurantId: '12345');

      expect(result, isNotEmpty);
      expect(result.length, 1);
      expect(result.first.id, '12345');
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

_restaurantMenuJson() {
  return [
    {
      "id": "12345",
      "name": "Lunch",
      "description": "a fun menu",
      "image_url": "menu.jpg",
      "items": [
        {
          "name": "nuff food",
          "description": "awasome!!",
          "image_urls": ["url1", "url2"],
          "unit_price": 12.99
        },
        {
          "name": "nuff food",
          "description": "awasome!!",
          "image_urls": ["url1", "url2"],
          "unit_price": 12.99
        }
      ]
    }
  ];
}
