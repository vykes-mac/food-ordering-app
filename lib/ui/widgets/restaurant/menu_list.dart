import 'package:flutter/material.dart';
import 'package:food_ordering_app/ui/widgets/custom_flat_button.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:restaurant/restaurant.dart';
import 'package:transparent_image/transparent_image.dart';

class MenuList extends StatefulWidget {
  final List<MenuItem> menuItems;

  MenuList(this.menuItems);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList>
    with AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            onTap: () {
              showAddToBasketOption(context, widget.menuItems[index]);
            },
            child: ListTile(
              isThreeLine: false,
              leading: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://picsum.photos/id/292/300',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.menuItems[index].name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Text(
                    doubleToCurrency(widget.menuItems[index].unitPrice),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
              subtitle: Text(
                widget.menuItems[index].description,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext _, index) => Divider(),
      itemCount: widget.menuItems.length,
    );
  }

  showAddToBasketOption(BuildContext context, MenuItem menuItem) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) => Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16, bottom: 20.0),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Text(
                    menuItem.name,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Text(
                  doubleToCurrency(menuItem.unitPrice),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline6,
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                    '1',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              CustomFlatButton(
                  onPressed: () {},
                  text: 'Add to Basket',
                  size: Size(double.infinity, 45),
                  color: Theme.of(context).accentColor)
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
