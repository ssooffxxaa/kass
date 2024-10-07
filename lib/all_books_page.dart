import 'package:flutter/material.dart';

class AllBooksPage extends StatelessWidget {
  final List<dynamic> books;

  const AllBooksPage({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ALL BOOKS',
          style: TextStyle(color: Colors.black), // เปลี่ยนสีฟอนต์เป็นสีดำ
        ),
        centerTitle: true,
        backgroundColor:
            Color.fromARGB(255, 255, 217, 92), // เปลี่ยนสีเป็นสีเหลือง
        iconTheme: const IconThemeData(
            color: Colors.black), // เปลี่ยนสีไอคอนกลับเป็นสีดำ
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16), // ระยะห่างระหว่างแต่ละรายการ
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1), // เส้นล้อมรอบ
              borderRadius: BorderRadius.circular(8), // ขอบมุมกลม
              color: Colors.white, // สีพื้นหลังของ Container
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8), // ระยะห่างภายใน
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4), // ขอบมุมกลมของรูปภาพ
                child: Image.asset(
                  books[index]['coverImage'] ?? 'assets/picture/defualt.jpg',
                  fit: BoxFit.cover,
                  width: 50,
                ),
              ),
              title: Text(books[index]['title']),
              subtitle: Text(books[index]['author']),
            ),
          );
        },
      ),
    );
  }
}
