import 'package:flutter/material.dart';
import 'package:restaurant/restaurant.dart';

abstract class ISearchResultsPageAdapter {
  void onRestaurantSelected(BuildContext context, Restaurant restaurant);
}

class SearchResultsPageAdapter implements ISearchResultsPageAdapter {
  final Widget Function(Restaurant restaurant) onSelection;

  SearchResultsPageAdapter({@required this.onSelection});
  @override
  void onRestaurantSelected(BuildContext context, Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSelection(restaurant),
      ),
    );
  }
}
