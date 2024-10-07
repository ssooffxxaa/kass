import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditBookScreen extends StatelessWidget {
  final String bookId;

  const EditBookScreen({Key? key, required this.bookId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchBookData(String bookId) async {
    var response =
        await http.get(Uri.parse('http://192.168.25.104:3000/books/$bookId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load book data');
    }
  }

  Future<void> _updateBook(String bookId, Map<String, dynamic> updatedData) async {
    var url = Uri.parse('http://192.168.25.104:3000/books/$bookId');
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      print('Book updated successfully');
    } else {
      print('Failed to update book');
      throw Exception('Failed to update book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EDIT BOOK',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 217, 92),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchBookData(bookId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          var bookData = snapshot.data!;
          String? _bookName = bookData['title'];
          String? _authorName = bookData['author'];
          String? _category = bookData['category'];
          String? _yearOfPublication = bookData['yearpubish'];
          String? _isbn = bookData['isbn'];

          final _formKey = GlobalKey<FormState>();

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _bookName,
                    decoration: InputDecoration(
                      labelText: "Book Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a book name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _bookName = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _authorName,
                    decoration: InputDecoration(
                      labelText: "Author Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an author name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authorName = value;
                    },
                  ),
                  const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                    value: _category,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    items: <String>['Fantasy', 'Romance', 'Mystery']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      _category = newValue;
                    },
                    onSaved: (value) {
                      _category = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _yearOfPublication,
                    decoration: InputDecoration(
                      labelText: "Year of Publication",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onSaved: (value) {
                      _yearOfPublication = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _isbn,
                    decoration: InputDecoration(
                      labelText: "ISBN",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onSaved: (value) {
                      _isbn = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 63, 142, 206),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Save", style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var updatedBook = {
                              'title': _bookName,
                              'author': _authorName,
                              'category': _category,
                              'yearpubish': _yearOfPublication,
                              'isbn': _isbn,
                            };
                            try {
                              await _updateBook(bookId, updatedBook);
                              Navigator.pop(context, true); // Return true to indicate successful update
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to update book: ${e.toString()}')),
                              );
                            }
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 219, 86, 77),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Cancel", style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
