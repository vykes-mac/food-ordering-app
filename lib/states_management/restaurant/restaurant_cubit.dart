import 'package:cubit/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ordering_app/states_management/restaurant/restaurant_state.dart';
import 'package:restaurant/restaurant.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final IRestaurantApi _api;
  final int _pageSize;

  RestaurantCubit(this._api, {int defaultPageSize = 30})
      : _pageSize = defaultPageSize,
        super(Initial());

  getAllRestaurants({@required int page}) async {
    _startLoading();
    final pageResult = await _api.getAllRestaurants(
      page: page,
      pageSize: _pageSize,
    );
    pageResult == null || pageResult.restaurants.isEmpty
        ? _showError('no restaurants found')
        : _setPageData(pageResult);
  }

  getRestaurantsByLocation(int page, Location location) async {
    _startLoading();
    final pageResult = await _api.getRestaurantsByLocation(
      page: page,
      pageSize: _pageSize,
      location: location,
    );

    pageResult == null || pageResult.restaurants.isEmpty
        ? _showError('no restaurants found')
        : _setPageData(pageResult);
  }

  search(int page, String query) async {
    _startLoading();
    final searchResults = await _api.findRestaurants(
      page: page,
      pageSize: _pageSize,
      searchTerm: query,
    );
    searchResults == null || searchResults.restaurants.isEmpty
        ? _showError('no restaurants found')
        : _setPageData(searchResults);
  }

  getRestaurant(String id) async {
    _startLoading();
    final restaurant = await _api.getRestaurant(id: id);
    restaurant != null
        ? emit(RestaurantLoaded(restaurant))
        : emit(ErrorState('restaurant not found'));
  }

  getRestaurantMenu(String restauranId) async {
    _startLoading();
    final menu = await _api.getRestaurantMenu(restaurantId: restauranId);
    menu.isNotEmpty
        ? emit(MenuLoaded(menu))
        : emit(ErrorState('no menu found for this restaurant'));
  }

  _startLoading() {
    emit(Loading());
  }

  _setPageData(Page result) {
    emit(PageLoaded(result));
  }

  _showError(String error) {
    emit(ErrorState(error));
  }
}
