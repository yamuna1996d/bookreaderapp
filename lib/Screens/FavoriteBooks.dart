import 'dart:convert';
import 'package:bookreaderapp/Screens/HomeScreen.dart';
import 'package:bookreaderapp/Widgets/BookTiles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constants.dart';
import '../Models/BookModel.dart';
import '../Widgets/TitleBold500.dart';

class FavoriteBooks extends StatefulWidget {
  const FavoriteBooks({super.key});

  @override
  _FavoriteBooksState createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends State<FavoriteBooks> {
  List<dynamic> favoriteBooks = [];
  List<String> stringFavorites = [];
  List<dynamic> favorites = [];
  List<dynamic> allBooks = [];
  @override
  void initState() {
    super.initState();
    fetchBooks().then((value) {
      loadFavorites().then((value) => loadFavoriteBooks());
    });
  }

  Future<void> fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        allBooks = data['items'];
      });
    }
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      stringFavorites = prefs.getStringList('favorites') ?? [];
      favorites = stringFavorites;
    });
  }

  Future<void> loadFavoriteBooks() async {
    List<dynamic> filteredBooks = allBooks.where((book) {
      return favorites.contains(book['id']);
    }).toList();

    setState(() {
      favoriteBooks = filteredBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        titleWidget: const TitleBold500(
          title: "Favorite Books",
          fontSize: 18,
        ),
        buttonCallBack: IconButton(
            onPressed: () {
              Navigator.pushNamed(context,"/");
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            )),
      ),
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final BookDetails books = BookDetails.fromJson(favoriteBooks[index]);
          return BooksTile(books: books);
        },
      ),
    );
  }
}
