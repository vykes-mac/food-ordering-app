import 'package:flutter/foundation.dart';
import 'package:restaurant/src/domain/restaurant.dart';

class Page {
  final int currentPage;
  final int pageSize;
  final List<Restaurant> restaurants;

  Page(
      {@required this.currentPage,
      @required this.pageSize,
      @required this.restaurants});
}
