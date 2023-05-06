import 'package:bookreaderapp/Models/BookModel.dart';
import 'package:bookreaderapp/api-Interface/Books.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookProvider with ChangeNotifier{

  List<BookDetails>books = [];
  List<dynamic> allBooks = [];
  int _page = 1;
  void incrementPage() {
    _page += 1;
    //notifyListeners();
  }

  resetPage() {
    _page = 1;
    //notifyListeners();
  }

  Future<List<BookDetails>> fetchBooks({bool reload = false}) async {
    if (reload) {
      resetPage();
    }
    final data = await BooksInterface.fetchBooks(
        _page, 10);
    books.addAll(data);
    notifyListeners();
    incrementPage();
    return data;
  }
}