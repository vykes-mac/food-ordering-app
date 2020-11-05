import 'package:flutter/foundation.dart';
import 'package:restaurant/src/domain/restaurant.dart';

class Page {
  final int currentPage;
  final int totalPages;
  bool get isLast => currentPage == totalPages;
  final List<Restaurant> restaurants;

  Page(
      {@required this.currentPage,
      @required this.totalPages,
      @required this.restaurants});
}
