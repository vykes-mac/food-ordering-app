import 'package:flutter/foundation.dart';

import './page.dart';
import '../domain/menu.dart';
import '../domain/restaurant.dart';

abstract class IRestaurantApi {
  Future<Page> getAllRestaurants({@required int page, @required int pageSize});
  Future<Page> getRestaurantsByLocation({
    @required int page,
    @required int pageSize,
    @required Location location,
  });
  Future<Page> findRestaurants({
    @required int page,
    @required int pageSize,
    @required String searchTerm,
  });
  Future<Restaurant> getRestaurant({@required String id});
  Future<List<Menu>> getRestaurantMenu({@required String restaurantId});
}
