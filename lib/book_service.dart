// lib/book_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';

class BookService {
  Future<List<dynamic>> loadBooks() async {
    final String response = await rootBundle.loadString('assets/books.json');
    final data = await json.decode(response);
    return data['books'];
  }
}
