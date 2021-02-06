import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter/foundation.dart';

import './page.dart';
import '../api/api_contract.dart';
import '../api/mapper.dart';
import '../domain/menu.dart';
import '../domain/restaurant.dart';

class RestaurantApi implements IRestaurantApi {
  final IHttpClient httpClient;
  final String baseUrl;
  RestaurantApi(this.baseUrl, this.httpClient);

  @override
  Future<Page> findRestaurants(
      {@required int page,
      @required int pageSize,
      @required String searchTerm}) async {
    final endpoint = baseUrl +
        '/restaurants/search?page=$page&limit=$pageSize&query=$searchTerm';
    final result = await httpClient.get(endpoint);
    return _parseRestaurantsJson(result);
  }

  @override
  Future<Page> getAllRestaurants(
      {@required int page, @required int pageSize}) async {
    final endpoint = baseUrl + '/restaurants?page=$page&limit=$pageSize';
    final result = await httpClient.get(endpoint);
    return _parseRestaurantsJson(result);
  }

  @override
  Future<Restaurant> getRestaurant({String id}) async {
    final endpoint = baseUrl + "/restaurants/restaurant/$id";
    final result = await httpClient.get(endpoint);
    if (result.status == Status.failure) return null;
    final json = jsonDecode(result.data);
    return Mapper.fromJson(json);
  }

  @override
  Future<Page> getRestaurantsByLocation(
      {int page, int pageSize, Location location}) async {
    final endpoint = baseUrl +
        '/restaurants/location?page=$page&limit=$pageSize&longitude=${location.longitude}&latitude=${location.latitude}';
    final result = await httpClient.get(endpoint);
    return _parseRestaurantsJson(result);
  }

  @override
  Future<List<Menu>> getRestaurantMenu({String restaurantId}) async {
    final endpoint = baseUrl + '/restaurants/restaurant/menu/$restaurantId';
    final result = await httpClient.get(endpoint);
    return _parseRestaurantMenu(result);
  }

  Page _parseRestaurantsJson(HttpResult result) {
    if (result.status == Status.failure) return null;

    final json = jsonDecode(result.data);
    final restaurants =
        json['restaurants'] != null ? _restaurantsFromJson(json) : [];
    return Page(
        currentPage: json['metadata']['page'],
        totalPages: json['metadata']['total_pages'],
        restaurants: restaurants);
  }

  List<Menu> _parseRestaurantMenu(HttpResult result) {
    if (result.status == Status.failure) return [];

    final json = jsonDecode(result.data);
    if (json['menu'] == null) return [];

    final List menus = json['menu'];
    return menus.map((ele) => Mapper.menuFromJson(ele)).toList();
  }

  List<Restaurant> _restaurantsFromJson(Map<String, dynamic> json) {
    final List restaurants = json['restaurants'];
    return restaurants.map<Restaurant>((ele) => Mapper.fromJson(ele)).toList();
  }
}
