import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/src/api/restaurant_api.dart';
import 'package:restaurant/src/domain/restaurant.dart';

class HttpClient extends Mock implements IHttpClient {}

void main() {
  RestaurantApi sut;
  HttpClient client;

  setUp(() {
    client = HttpClient();
    sut = RestaurantApi('baseUrl', client);
  });

  group('getAllRestaurants', () {
    test('returns an empty list when no restaurants are found', () async {
      //arrange
      when(client.get(any)).thenAnswer((_) async => HttpResult(
          jsonEncode({
            "metadata": {"page": 1, "limit": 2},
            "restaurants": []
          }),
          Status.success));
      //act
      final page = await sut.getAllRestaurants(page: 1, pageSize: 2);

      //assert
      expect(page.restaurants, []);
    });
    test('returns null when status is not 200', () async {
      //arrange
      when(client.get(any))
          .thenAnswer((_) async => HttpResult(jsonEncode({}), Status.failure));
      //act
      final page = await sut.getAllRestaurants(page: 1, pageSize: 2);

      //assert
      expect(page, isNull);
    });
    test('resturns list of restaurants when success', () async {
      //arrange
      when(client.get(any)).thenAnswer((_) async =>
          HttpResult(jsonEncode(_restaurantsJson()), Status.success));
      //act
      final page = await sut.getAllRestaurants(page: 1, pageSize: 2);

      //assert
      expect(page.restaurants.length, 2);
    });
  });

  group('getRestaurant', () {
    test('returns null when restaurant is not found', () async {
      when(client.get(any)).thenAnswer((_) async => HttpResult(
          jsonEncode({"error": "restaurant not found"}), Status.failure));

      final result = await sut.getRestaurant(id: '1234');

      expect(result, null);
    });
    test('returns restaurant when success', () async {
      when(client.get(any)).thenAnswer((_) async => HttpResult(
          jsonEncode(_restaurantsJson()["restaurants"][0]), Status.success));

      final result = await sut.getRestaurant(id: '12345');

      expect(result, isNotNull);
      expect(result.id, '12345');
    });
  });

  group('findRestaurants', () {
    test('returns empty list when no restaurants are found', () async {
      when(client.get(any)).thenAnswer((_) async => HttpResult(
          jsonEncode({
            "metadata": {"page": 1, "limit": 2},
            "restaurants": []
          }),
          Status.success));

      final page = await sut.findRestaurants(
          page: 1, pageSize: 2, searchTerm: 'good food');

      expect(page.restaurants, []);
    });
    test('returns restaurant when success', () async {
      when(client.get(any)).thenAnswer((_) async =>
          HttpResult(jsonEncode(_restaurantsJson()), Status.success));

      final page = await sut.findRestaurants(
          page: 1, pageSize: 2, searchTerm: 'good food');

      expect(page.restaurants.length, 2);
    });
  });

  group('getRestaurantsByLocation', () {
    test('returns empty list when no restaurants are found', () async {
      when(client.get(any)).thenAnswer((_) async => HttpResult(
          jsonEncode({
            "metadata": {"page": 1, "limit": 2},
            "restaurants": []
          }),
          Status.success));

      final page = await sut.getRestaurantsByLocation(
        page: 1,
        pageSize: 2,
        location: Location(longitude: 232.2, latitude: 2323.45),
      );

      expect(page.restaurants, []);
    });
    test('returns restaurant when success', () async {
      when(client.get(any)).thenAnswer((_) async =>
          HttpResult(jsonEncode(_restaurantsJson()), Status.success));

      final result = await sut.getRestaurantsByLocation(
        page: 1,
        pageSize: 2,
        location: Location(longitude: 232.2, latitude: 2323.45),
      );

      expect(result.restaurants.length, 2);
    });
  });

  group('getRestaurantMenu', () {
    test('returns empty list when no menu is found', () async {
      when(client.get(any)).thenAnswer(
          (_) async => HttpResult(jsonEncode({"menu": []}), Status.failure));

      final result = await sut.getRestaurantMenu(restaurantId: '1234');

      expect(result, []);
    });
    test('returns restaurant menu when success', () async {
      when(client.get(any)).thenAnswer((_) async => HttpResult(
          jsonEncode({"menu": _restaurantMenuJson()}), Status.success));

      final result = await sut.getRestaurantMenu(restaurantId: '1234');

      expect(result, isNotEmpty);
      expect(result.length, 1);
      expect(result.first.id, '12345');
    });
  });
}

_restaurantsJson() {
  return {
    "metadata": {"page": 1, "totalPages": 2},
    "restaurants": [
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
    ]
  };
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
