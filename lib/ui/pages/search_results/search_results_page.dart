import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ordering_app/states_management/restaurant/restaurant_cubit.dart';
import 'package:food_ordering_app/states_management/restaurant/restaurant_state.dart';
import 'package:food_ordering_app/ui/pages/search_results/search_results_page_adapter.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:restaurant/restaurant.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchResultsPage extends StatefulWidget {
  final RestaurantCubit restaurantCubit;
  final String query;
  final ISearchResultsPageAdapter adapter;

  SearchResultsPage(this.restaurantCubit, this.query, this.adapter);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<Restaurant> restaurants = [];
  PageLoaded currentState;
  bool fetchMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.restaurantCubit.search(1, widget.query);
    super.initState();
    _onScrollListener();
  }

  void _onScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
              _scrollController.position.maxScrollExtent &&
          currentState.nextPage != null) {
        fetchMore = true;
        widget.restaurantCubit.search(
          currentState.nextPage,
          widget.query,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 30.0,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${widget.query} Results',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: _buildResults(),
            )
          ],
        ),
      ),
    );
  }

  _buildResults() {
    return CubitBuilder<RestaurantCubit, RestaurantState>(
      cubit: widget.restaurantCubit,
      builder: (_, state) {
        if (state is PageLoaded) {
          currentState = state;
          fetchMore = false;
          restaurants.addAll(state.restaurants);
        }
        if (state is ErrorState) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          );
        }

        if (currentState == null)
          return Center(child: CircularProgressIndicator());

        return _buildResultsList();
      },
    );
  }

  _buildResultsList() => ListView.separated(
      itemBuilder: (context, index) {
        return index >= restaurants.length
            ? bottomLoader()
            : Material(
                child: InkWell(
                  onTap: () => widget.adapter.onRestaurantSelected(
                    context,
                    restaurants[index],
                  ),
                  child: ListTile(
                    leading: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: 'https://picsum.photos/id/292/300',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurants[index].name,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        RatingBarIndicator(
                          rating: 4.5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                          itemSize: 25.0,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "${restaurants[index].address.street}, ${restaurants[index].address.city}, ${restaurants[index].address.parish}",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              );
      },
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      separatorBuilder: (BuildContext _, index) => Divider(),
      itemCount: !fetchMore ? restaurants.length : restaurants.length + 1);
}
