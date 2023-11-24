// screens/book_list.dart
import 'package:flutter/material.dart';
import 'package:reading_app1/models/book.dart';
import 'book_detail_screen.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  BookList({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(books[index].title),
          subtitle: Text(books[index].description),
          leading: Image.network(
            books[index].coverImage,
            width: 50,
            height: 50,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(
                  book: books[index], // Pass the entire Book object
                ),
              ),
            );
          },
        );
      },
    );
  }
}
