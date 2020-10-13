import 'package:flutter/foundation.dart';

import '../domain/restaurant.dart';

abstract class IRestaurantApi {
  Future<List<Restaurant>> getAllRestaurants({@required int page});
  Future<List<Restaurant>> getRestaurantByLocation({
    @required int page,
    @required Location location,
  });
  Future<List<Restaurant>> findRestaurants({
    @required int page,
    @required String searchTerm,
  });
  Future<Restaurant> getRestaurant({@required String id});
  Future<Restaurant> getRestaurantMenu({@required String restaurantId});
}
