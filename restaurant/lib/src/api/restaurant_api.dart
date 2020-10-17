import 'dart:convert';

import 'package:http/http.dart';

import '../api/api_contract.dart';
import '../api/mapper.dart';
import '../domain/menu.dart';
import '../domain/restaurant.dart';

class RestaurantApi implements IRestaurantApi {
  final Client httpClient;
  final String baseUrl;
  RestaurantApi(this.baseUrl, this.httpClient);

  @override
  Future<List<Restaurant>> findRestaurants(
      {int page, String searchTerm}) async {
    final endpoint = baseUrl + '/search/page=$page&term=$searchTerm';
    final response = await httpClient.get(endpoint);
    return _parseRestaurantsJson(response);
  }

  @override
  Future<List<Restaurant>> getAllRestaurants({int page}) async {
    final endpoint = baseUrl + '/restaurants/page=$page';
    final response = await httpClient.get(endpoint);
    return _parseRestaurantsJson(response);
  }

  @override
  Future<Restaurant> getRestaurant({String id}) async {
    final endpoint = baseUrl + "/restaurant/$id";
    final response = await httpClient.get(endpoint);
    if (response.statusCode != 200) return null;
    final json = jsonDecode(response.body);
    return Mapper.fromJson(json);
  }

  @override
  Future<List<Restaurant>> getRestaurantByLocation(
      {int page, Location location}) async {
    final endpoint = baseUrl +
        '/restaurant/page=$page&longitude=${location.longitude}&latitude=${location.latitude}';
    final response = await httpClient.get(endpoint);
    return _parseRestaurantsJson(response);
  }

  @override
  Future<List<Menu>> getRestaurantMenu({String restaurantId}) async {
    final endpoint = baseUrl + '/restaurnt/menu/$restaurantId';
    final response = await httpClient.get(endpoint);
    return _parseRestaurantMenu(response);
  }

  List<Restaurant> _parseRestaurantsJson(Response response) {
    if (response.statusCode != 200) return [];

    final json = jsonDecode(response.body);
    return json['restaurants'] != null ? _restaurantsFromJson(json) : [];
  }

  List<Menu> _parseRestaurantMenu(Response response) {
    if (response.statusCode != 200) return [];

    final json = jsonDecode(response.body);
    if (json['menu'] == null) return [];

    final List menus = json['menu'];
    return menus.map((ele) => Mapper.menuFromJson(ele)).toList();
  }

  List<Restaurant> _restaurantsFromJson(Map<String, dynamic> json) {
    final List restaurants = json['restaurants'];
    return restaurants.map<Restaurant>((ele) => Mapper.fromJson(ele)).toList();
  }
}
