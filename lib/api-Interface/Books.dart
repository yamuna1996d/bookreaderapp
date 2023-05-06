


import 'package:bookreaderapp/Models/BookModel.dart';
import '../api/api_exception.dart';
import '../api/api_methods.dart';
import '../api/api_request.dart';

class BooksInterface{
  static Future<List<BookDetails>> fetchBooks(int page, int limit) async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "volumes?q=flutter",
          queries: {
            "startIndex": page,
            "maxResults": limit,
          });

      if (response != null) {
        return BookDetails.convertToList(response['items']);
      }
      return [];
    } catch (err) {
      print("Fetching Books error: $err");
      throw ApiException(err.toString());
    }
  }

  static Future<List<BookDetails>> fetchAllBooks() async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "volumes?q=flutter",
          );

      if (response != null) {
        return BookDetails.convertToList(response['items']);
      }
      return [];
    } catch (err) {
      print("Fetching Books error: $err");
      throw ApiException(err.toString());
    }
  }
}