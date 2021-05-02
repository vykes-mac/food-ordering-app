import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';

class MainPageCubit extends Cubit<int> {
  List<Widget Function()> _pagesToCompose;
  Widget get currentPage => _pagesToCompose[state]();
  // Map<int, Widget> loadedPages = {};
  // Widget get currentPage {
  //   if (!loadedPages.containsKey(state))
  //     loadedPages[state] = _pagesToCompose[state]();
  //   return loadedPages[state];
  // }

  MainPageCubit({@required pagesToCompose}) : super(0) {
    this._pagesToCompose = pagesToCompose;
  }

  void currentIndex(int index) => emit(index);
}
