import 'package:flutter/material.dart';
import 'package:restaurant/restaurant.dart';

abstract class IHomePageAdapter {
  void onSearchQuery(BuildContext context, String query);
  void onRestaurantSelected(BuildContext context, Restaurant restaurant);
  void onUserLogout(BuildContext context);
}

class HomePageAdapter implements IHomePageAdapter {
  final Widget Function(Restaurant restaurant) onSelection;
  final Widget Function(String query) onSearch;
  final Widget Function() onLogout;

  HomePageAdapter({
    @required this.onSelection,
    @required this.onSearch,
    this.onLogout,
  });

  @override
  void onSearchQuery(BuildContext context, String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSearch(query),
      ),
    );
  }

  @override
  void onRestaurantSelected(BuildContext context, Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSelection(restaurant),
      ),
    );
  }

  @override
  void onUserLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => onLogout(),
        ),
        (Route<dynamic> route) => false);
  }
}
