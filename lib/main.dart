// สำหรับการจัดการ JSON
import 'package:flutter/material.dart';
// สำหรับการโหลดไฟล์
// ignore: unused_import
import 'package:flutter_application_1/all_books_page.dart';
// import 'package:flutter_application_1/category_books_page.dart';
import 'search_page.dart';
import 'menu_page.dart';
import 'add_book.dart'; // Import AddBookScreen
import 'edit_book.dart';
import 'delete_book.dart'; // Import DeleteBookScreen
import 'package:flutter_application_1/book_service.dart'; // Import BookService

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LibraryPage(),
        '/search': (context) => const SearchPage(),
        '/menu': (context) => const MenuPage(),
        '/addBook': (context) => AddBookScreen(), // Add route for AddBookScreen
      },
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<dynamic> books = [];
  final BookService _bookService =
      BookService(); // สร้าง instance ของ BookService

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final loadedBooks = await _bookService.loadBooks();
    setState(() {
      books = loadedBooks;
    });
  }

  void deleteBook(String bookId) {
    setState(() {
      books.removeWhere((book) => book['id'] == bookId);
    });

    // ถ้าต้องการบันทึกการเปลี่ยนแปลงกลับไปยังไฟล์ JSON
    // สามารถใช้แพ็กเกจเช่น path_provider และ dart:io ในการเขียนข้อมูลใหม่ไปยังไฟล์ JSON
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'LIBRARY',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 217, 92),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton('Mystery', screenWidth),
                const SizedBox(width: 20),
                _buildCategoryButton('Romance', screenWidth),
                const SizedBox(width: 20),
                _buildCategoryButton('Fantasy', screenWidth),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: books.take(5).map((book) {
                return Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(book['coverImage']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Books',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildSeeAllButton(screenWidth),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return BookListItem(
                    id: books[index]["id"],
                    title: books[index]['title'],
                    author: books[index]['author'],
                    coverImage: books[index]['coverImage'] ??
                        '/assets/picture/defualt.jpg',
                    deleteBook:
                        deleteBook, // ส่งฟังก์ชัน deleteBook ไปยัง BookListItem
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // เพิ่ม Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookScreen()),
          );
          if (result == true) {
            loadBooks();
            // BookService().loadBooks();
          }
        },
        child: const Icon(Icons.add), // ปุ่มรูปเครื่องหมายบวก
        backgroundColor: Color.fromARGB(255, 255, 217, 92), // สีของปุ่ม
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home,
                  color: Color.fromARGB(255, 253, 209, 63)),
              onPressed: () {
                // ฟังก์ชันสำหรับกดปุ่ม Home
              },
            ),
            IconButton(
              icon: const Icon(Icons.search,
                  color: Color.fromARGB(255, 253, 209, 63)),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu,
                  color: Color.fromARGB(255, 253, 209, 63)),
              onPressed: () {
                Navigator.pushNamed(context, '/menu');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, double screenWidth) {
    return Container(
      width: screenWidth * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 217, 92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      alignment: Alignment.center,
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSeeAllButton(double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 217, 92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      child: const Text(
        'See all',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  final String title;
  final String author;
  final String coverImage;
  final String id;
  final Function deleteBook; // เพิ่มตัวแปรสำหรับฟังก์ชัน deleteBook

  const BookListItem({
    Key? key,
    required this.title,
    required this.author,
    required this.coverImage,
    required this.id,
    required this.deleteBook, // รับฟังก์ชัน deleteBook ผ่าน constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ภาพปกหนังสือ
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(coverImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ชื่อหนังสือ
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // ชื่อนักเขียน
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.1, horizontal: 5), // ปรับ padding ให้เล็กลง
                decoration: BoxDecoration(
                  color: Colors.blue
                      .withOpacity(0.1), // เพิ่มสีพื้นหลังให้กับปุ่ม Edit
                  borderRadius: BorderRadius.circular(10), // ปรับมุมให้โค้ง
                ),
                child: TextButton(
                  onPressed: () async {
                    print('Edit button pressed for book id: $id');
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditBookScreen(bookId: id),
                      ),
                    );

                    if (result == true) {
                      // โหลดข้อมูลใหม่และอัปเดต state หลังแก้ไขหนังสือ
                      loadBooks();
                    }
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 10, // ปรับขนาดฟอนต์ให้เล็กลง
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // เพิ่มระยะห่างระหว่างปุ่ม Edit และ Delete
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.1, horizontal: 5), // ปรับ padding ให้เล็กลง
                decoration: BoxDecoration(
                  color: Colors.red
                      .withOpacity(0.1), // เพิ่มสีพื้นหลังให้กับปุ่ม Delete
                  borderRadius: BorderRadius.circular(10), // ปรับมุมให้โค้ง
                ),
                child: TextButton(
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteBookScreen(
                          bookId: id,
                          onDelete: (String bookId) {
                            deleteBook(bookId); // เรียกฟังก์ชันลบหนังสือ
                          },
                        );
                      },
                    );

                    if (result == true) {
                      print('Deleted book with id: $id');
                      // BookService().loadBooks();
                      loadBooks();

                    }
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 10, // ปรับขนาดฟอนต์ให้เล็กลง
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  loadBooks() {}
}
