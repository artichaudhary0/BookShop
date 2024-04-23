import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assessment/model/book_model.dart';

class BookService {
  static Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://openlibrary.org/search.json?q=$query',
      ),
    );

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      if (data['error'] != null) {
        throw Exception('Error fetching books: ${data['error']}');
      }
      final List<dynamic>? booksData = data['docs'];
      if (booksData != null) {
        return booksData.map((item) => Book.fromJson(item)).toList();
      } else {
        throw Exception('No books data found');
      }
    } else {
      throw Exception('Failed to fetch books');
    }
  }
}
