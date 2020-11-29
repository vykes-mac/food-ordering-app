import 'package:flutter/material.dart';
import 'package:food_ordering_app/states_management/restaurant/restaurant_cubit.dart';

import 'search_results_page.dart';

abstract class IHomePageAdapter {
  void onSearchQuery(BuildContext context, String query);
}

class HomePageAdapter implements IHomePageAdapter {
  final RestaurantCubit _restaurantCubit;

  HomePageAdapter(this._restaurantCubit);

  @override
  void onSearchQuery(BuildContext context, String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsPage(_restaurantCubit, query),
      ),
    );
  }
}
