import 'package:flutter/foundation.dart';

class Menu {
  String id;
  String name;
  String description;
  String displayImgUrl;
  List<MenuItem> items;

  Menu({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.items,
    this.displayImgUrl,
  });
}

class MenuItem {
  String name;
  String description;
  List<String> imageUrls;
  double unitPrice;

  MenuItem({
    @required this.name,
    @required this.description,
    this.imageUrls,
    @required this.unitPrice,
  });
}
