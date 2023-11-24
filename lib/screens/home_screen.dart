// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:reading_app1/models/book.dart';
import 'package:reading_app1/screens/book_search_delegate.dart';
import 'book_list.dart';

class HomeScreen extends StatelessWidget {
  final List<Book> books;

  HomeScreen({required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: [
          // Search bar
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate(books));
            },
          ),
        ],
      ),
      body: BookList(books: books),
    );
  }
}
