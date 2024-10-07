import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditBookScreen extends StatelessWidget {
  final String bookId; // รับค่า id ของหนังสือที่ต้องการแก้ไข

  const EditBookScreen({Key? key, required this.bookId}) : super(key: key);

  // ฟังก์ชั่นเพื่อดึงข้อมูลหนังสือตาม id
  Future<Map<String, dynamic>> _fetchBookData(String bookId) async {
    var response =
        await http.get(Uri.parse('http://localhost:3000/books/${bookId}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load book data');
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _bookName,
                    decoration: InputDecoration(labelText: "Book Name"),
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
                  TextFormField(
                    initialValue: _authorName,
                    decoration: InputDecoration(labelText: "Author Name"),
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
                  TextFormField(
                    initialValue: _category,
                    decoration: InputDecoration(labelText: "Category"),
                    onSaved: (value) {
                      _category = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _yearOfPublication,
                    decoration:
                        InputDecoration(labelText: "Year of Publication"),
                    onSaved: (value) {
                      _yearOfPublication = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _isbn,
                    decoration: InputDecoration(labelText: "ISBN"),
                    onSaved: (value) {
                      _isbn = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text("Save"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // เรียกใช้ฟังก์ชันอัปเดตหนังสือที่นี่
                          }
                        },
                      ),
                      ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
