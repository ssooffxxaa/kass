// import 'package:flutter/material.dart';

// class CategoryBooksPage extends StatelessWidget {
//   final String category;
//   final List<dynamic> books;

//   const CategoryBooksPage({
//     Key? key,
//     required this.category,
//     required this.books,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // กรองหนังสือโดยดูจากประเภท
//     List<dynamic> filteredBooks = books.where((book) {
//       return book['category'] == category;
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '$category Books',
//           style: const TextStyle(color: Colors.black), // เปลี่ยนสีฟอนต์เป็นสีดำ
//         ),
//         centerTitle: true,
//         backgroundColor:
//             Color.fromARGB(255, 255, 217, 92), // เปลี่ยนสีเป็นสีเหลือง
//         iconTheme: const IconThemeData(
//             color: Colors.black), // เปลี่ยนสีไอคอนกลับเป็นสีดำ
//       ),
//       body: ListView.builder(
//         itemCount: filteredBooks.length,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: const EdgeInsets.symmetric(
//                 vertical: 8, horizontal: 16), // ระยะห่างระหว่างแต่ละรายการ
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey, width: 1), // เส้นล้อมรอบ
//               borderRadius: BorderRadius.circular(8), // ขอบมุมกลม
//               color: Colors.white, // สีพื้นหลังของ Container
//             ),
//             child: ListTile(
//               contentPadding: const EdgeInsets.all(8), // ระยะห่างภายใน
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(4), // ขอบมุมกลมของรูปภาพ
//                 child: Image.asset(
//                   filteredBooks[index]['coverImage'],
//                   width: 50,
//                   height: 75,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               title: Text(filteredBooks[index]['title']),
//               subtitle: Text(filteredBooks[index]['author']),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
