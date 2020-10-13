import 'dart:convert';

import 'package:http/http.dart';

import '../api/api_contract.dart';
import '../api/mapper.dart';
import '../domain/restaurant.dart';

class RestaurantApi implements IRestaurantApi {
  final Client httpClient;
  final String baseUrl;
  RestaurantApi(this.baseUrl, this.httpClient);

  @override
  Future<List<Restaurant>> findRestaurants({int page, String searchTerm}) {
    // TODO: implement findRestaurants
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurant>> getAllRestaurants({int page}) async {
    final endpoint = baseUrl + '/restaurants/page=$page';
    final response = await httpClient.get(endpoint);
    return _parseRestaurantsJson(response);
  }

  @override
  Future<Restaurant> getRestaurant({String id}) {
    // TODO: implement getRestaurant
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurant>> getRestaurantByLocation(
      {int page, Location location}) {
    // TODO: implement getRestaurantByLocation
    throw UnimplementedError();
  }

  @override
  Future<Restaurant> getRestaurantMenu({String restaurantId}) {
    // TODO: implement getRestaurantMenu
    throw UnimplementedError();
  }

  List<Restaurant> _parseRestaurantsJson(Response response) {
    if (response.statusCode != 200) return [];

    final json = jsonDecode(response.body);
    return json['restaurants'] != null ? _restaurantsFromJson(json) : [];
  }

  List<Restaurant> _restaurantsFromJson(Map<String, dynamic> json) {
    final List restaurants = json['restaurants'];
    return restaurants.map<Restaurant>((ele) => Mapper.fromJson(ele)).toList();
  }
}
