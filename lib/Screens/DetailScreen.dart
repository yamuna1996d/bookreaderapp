import 'package:bookreaderapp/Screens/HomeScreen.dart';
import 'package:bookreaderapp/Utils/Constants.dart';
import 'package:bookreaderapp/Models/BookModel.dart';
import 'package:bookreaderapp/Widgets/BookDetails.dart';
import 'package:bookreaderapp/Widgets/Description.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/PrefHelper.dart';
import 'FavoriteBooks.dart';

class DetailScreen extends StatefulWidget {
  final BookDetails? books;
  const DetailScreen({Key? key, this.books}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> favorites = [];

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> toggleFavorite(String bookId) async {
    List<String> updatedFavorites = List.from(favorites);
    if (favorites.contains(bookId)) {
      updatedFavorites.remove(bookId);
    } else {
      updatedFavorites.add(bookId);
    }
    setState(() {
      favorites = updatedFavorites;
    });
    await PrefsHelper.setFavorites(favorites);
  }

  bool isFavorite(String bookId) {
    return favorites.contains(bookId);
  }

  @override
  void initState() {
    loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          buttonCallBack: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: blackColor,
              )),
          favoriteButton: IconButton(
              onPressed: () {
                Navigator.pushNamed(context,"/favorite");
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ))),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookDetail(
              books: widget.books,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.only(left: 10),
              height: 220,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 50),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.books?.volumeInfo?.imageLinks?.thumbnail ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 10,
                      child: InkWell(
                        onTap: () {
                          toggleFavorite(widget.books?.id ?? "");
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(
                                    0.5, 0.5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite(widget.books?.id ?? "")
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Description(
              description: widget.books?.volumeInfo?.description,
              count: widget.books?.volumeInfo?.pageCount.toString(),
            )
          ],
        ),
      ),
    );
  }
}
