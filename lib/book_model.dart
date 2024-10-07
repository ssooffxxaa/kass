// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

Books booksFromJson(String str) => Books.fromJson(json.decode(str));

String booksToJson(Books data) => json.encode(data.toJson());

class Books {
  List<Book>? books;

  Books({
    this.books,
  });

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        books: json["books"] == null
            ? []
            : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": books == null
            ? []
            : List<dynamic>.from(books!.map((x) => x.toJson())),
      };
}

class Book {
  String? title;
  String? author;
  String? coverImage;
  String? category;
  String? yearpubish;
  String? isbn;

  Book({
    this.title,
    this.author,
    this.coverImage,
    this.category,
    this.yearpubish,
    this.isbn,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        author: json["author"],
        coverImage: json["coverImage"],
        category: json["category"],
        yearpubish: json["yearpubish"],
        isbn: json["isbn"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "coverImage": coverImage,
        "category": category,
        "yearpubish": yearpubish,
        "isbn": isbn,
      };
}
