// screens/book_search_delegate.dart
import 'package:flutter/material.dart';
import 'package:reading_app1/models/book.dart';

class BookSearchDelegate extends SearchDelegate<String> {
  final List<Book> books;

  BookSearchDelegate(this.books);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results based on the query and books list
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions based on the query and books list
    return Center(
      child: Text('Search suggestions for: $query'),
    );
  }
}
