import 'package:flutter/material.dart';
import 'search_page.dart'; // นำเข้าหน้า Search
import 'main.dart'; // นำเข้าหน้า Library

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIBRARY',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black), // เปลี่ยนให้ข้อความหนา
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 217, 92),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ไอคอน user และข้อความ
            Row(
              children: [
                Icon(Icons.person, size: 24.0),
                SizedBox(width: 8.0), // ช่องว่างระหว่างไอคอนกับข้อความ
                Text(
                  'Personal information',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            // ไอคอน right arrow
            Icon(Icons.arrow_forward_ios, size: 16.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 253, 209, 63)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LibraryPage()), // เปลี่ยนไปยังหน้า Home
                );
              },
            ),
            IconButton(
              icon:
                  Icon(Icons.search, color: Color.fromARGB(255, 253, 209, 63)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchPage()), // เปลี่ยนไปยังหน้า Search
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.menu, color: Color.fromARGB(255, 253, 209, 63)),
              onPressed: () {
                // ถ้าต้องการกลับไปที่หน้า Menu (ในกรณีนี้ไม่ต้องทำอะไร)
              },
            ),
          ],
        ),
      ),
    );
  }
}
