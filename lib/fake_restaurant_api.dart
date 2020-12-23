import 'package:faker/faker.dart' as ff;
import 'package:restaurant/restaurant.dart';

class FakeRestaurantApi implements IRestaurantApi {
  List<Restaurant> _restaurants;
  List<Menu> _restaurantMenus = [];

  FakeRestaurantApi(int numberOfRestaurants) {
    final faker = ff.Faker();
    _restaurants = List.generate(
      numberOfRestaurants,
      (index) => Restaurant(
        id: index.toString(),
        name: faker.company.name(),
        type: faker.food.cuisine(),
        displayImgUrl: faker.internet.httpUrl(),
        address: Address(
          street: faker.address.streetName(),
          city: faker.address.city(),
          parish: faker.address.country(),
        ),
        location: Location(
          longitude: faker.randomGenerator.integer(5).toDouble(),
          latitude: faker.randomGenerator.integer(5).toDouble(),
        ),
      ),
    );

    _restaurants.forEach((restaurant) {
      var menus = List.generate(
        faker.randomGenerator.integer(5),
        (index) => Menu(
          id: restaurant.id,
          name: faker.food.dish(),
          description: faker.lorem.sentences(2).join(),
          items: List.generate(
            faker.randomGenerator.integer(15),
            (_) => MenuItem(
              name: faker.food.dish(),
              description: faker.lorem.sentence(),
              unitPrice:
                  faker.randomGenerator.integer(5000, min: 500).toDouble(),
            ),
          ),
        ),
      );
      _restaurantMenus.addAll(menus);
    });
  }

  @override
  Future<Page> findRestaurants(
      {int page, int pageSize, String searchTerm}) async {
    final filter = searchTerm != null
        ? (Restaurant res) =>
            res.name.toLowerCase().contains(searchTerm.toLowerCase().trim())
        : null;
    await Future.delayed(Duration(seconds: 2));

    return _paginatedRestaurants(page, pageSize, filter: filter);
  }

  @override
  Future<Page> getAllRestaurants({int page, int pageSize}) async {
    await Future.delayed(Duration(seconds: 2));
    return _paginatedRestaurants(page, pageSize);
  }

  @override
  Future<Restaurant> getRestaurant({String id}) async {
    return this
        ._restaurants
        .singleWhere((restaurant) => restaurant.id == id, orElse: () => null);
  }

  @override
  Future<List<Menu>> getRestaurantMenu({String restaurantId}) async {
    await Future.delayed(Duration(seconds: 2));
    return _restaurantMenus.where((menu) => menu.id == restaurantId).toList();
  }

  @override
  Future<Page> getRestaurantsByLocation(
      {int page, int pageSize, Location location}) async {
    final filter =
        location != null ? (Restaurant res) => res.location == location : null;
    return _paginatedRestaurants(page, pageSize, filter: filter);
  }

  Page _paginatedRestaurants(int page, int pageSize,
      {Function(Restaurant) filter}) {
    final int offset = (page - 1) * pageSize;
    final restaurants = filter == null
        ? this._restaurants
        : this._restaurants.where(filter).toList();
    final totalPages = (restaurants.length / pageSize).ceil();

    final result = restaurants.skip(offset).take(pageSize).toList();

    return Page(currentPage: page, totalPages: totalPages, restaurants: result);
  }
}
