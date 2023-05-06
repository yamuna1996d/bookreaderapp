import 'package:bookreaderapp/Utils/Constants.dart';
import 'package:bookreaderapp/Models/BookModel.dart';
import 'package:bookreaderapp/Widgets/BookTiles.dart';
import 'package:bookreaderapp/Widgets/TitleBold500.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../providers/BookProvider.dart';
import 'FavoriteBooks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  static const _pageSize = 10;
  bool _isLast = false;
  //The PagingController class is used to manage pagination and provide the items to be displayed in the PagedGridView
  final PagingController<int, BookDetails> _pagingController =
      PagingController(firstPageKey: 1);

  reload() {
    Provider.of<BookProvider>(context, listen: false).resetPage();
    _pagingController.refresh();
    setState(() {});
  }

  @override
  void initState() {
    Provider.of<BookProvider>(context, listen: false).resetPage();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  /* The _fetchPage method is used to fetch the next page of items to be displayed in the grid.
   It calls the fetchHome method of the HomeProvider to get the items and then appends them to the PagingController using the appendPage method.
   If the last page of items has been reached, the appendLastPage method is called instead.*/
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await Provider.of<BookProvider>(context, listen: false).fetchBooks();
      setState(() {
        _isLast = newItems.length < _pageSize;
      });
      if (_isLast) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          context: context,
          titleWidget: const TitleBold500(
            title: "All Books",
            fontSize: 18,
          ),
          favoriteButton: IconButton(
              onPressed: () {
                Navigator.pushNamed(context,"/favorite");
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ))
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TitleBold500(
                  title: 'What would you like to read today?',
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                    // The onRefresh callback is used to refresh the data displayed in the grid when the user pulls down on the screen.
                    // The resetPage method of the HomeProvider is called to reset the current page to 1,
                    // and the refresh method of the PagingController is called to fetch the new data.
                    onRefresh: () {
                      Provider.of<BookProvider>(context, listen: false)
                          .resetPage();
                      return Future.sync(() {
                        _pagingController.refresh();
                      });
                    },
                    child: PagedListView<int, BookDetails>(
                      pagingController: _pagingController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      builderDelegate: PagedChildBuilderDelegate(
                        animateTransitions: true,
                        itemBuilder: (context, item, index) {
                          return BooksTile(
                            books: item,
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) =>
                            const Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.red,
                            radius: 20,
                          ),
                        ),
                        //AppLoader(),
                        newPageProgressIndicatorBuilder: (context) =>
                            const Center(
                          child: CupertinoActivityIndicator(
                            radius: 20,
                            color: Colors.red,
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (context) =>
                            const Center(child: Text("No Data Found")),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
