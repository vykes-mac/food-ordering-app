import 'package:equatable/equatable.dart';
import 'package:restaurant/restaurant.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}

class Initial extends RestaurantState {
  const Initial();

  @override
  List<Object> get props => [];
}

class Loading extends RestaurantState {
  const Loading();

  @override
  List<Object> get props => [];
}

class PageLoaded extends RestaurantState {
  List<Restaurant> get restaurants => _page.restaurants;
  final Page _page;
  int get nextPage => _page.isLast ? null : this._page.currentPage + 1;

  const PageLoaded(this._page);

  @override
  List<Object> get props => [_page];
}

class RestaurantLoaded extends RestaurantState {
  final Restaurant restaurant;

  const RestaurantLoaded(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class MenuLoaded extends RestaurantState {
  final List<Menu> menu;
  const MenuLoaded(this.menu);

  @override
  List<Object> get props => [menu];
}

class ErrorState extends RestaurantState {
  final String message;

  const ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
