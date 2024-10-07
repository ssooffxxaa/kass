import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteBookScreen extends StatelessWidget {
  final String bookId;
  final Function onDelete;

  const DeleteBookScreen({
    Key? key,
    required this.bookId,
    required this.onDelete,
  }) : super(key: key);

  // Function to delete the book from the server
  Future<void> deleteBook(String id) async {
    final url = 'http://192.168.25.104:3000/books/$id'; // URL สำหรับลบหนังสือ
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Book deleted successfully');
      } else {
        print('Failed to delete the book');
      }
    } catch (error) {
      print('Error deleting book: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'DELETE BOOK',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 217, 92),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 253, 209, 63),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'ยืนยันการลบ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 20, 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await deleteBook(bookId); // Call the delete function
                      onDelete(bookId);
                      Navigator.pop(context, true); // ปิดหน้าหลังจากลบเสร็จ
                    },
                    child: const Text('ลบ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 50, 156, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // กลับไปที่หน้าก่อนหน้านี้
                    },
                    child: const Text('ยกเลิก',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 77, 77),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
