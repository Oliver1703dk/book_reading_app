import 'dart:async';

import 'package:reading_app1/models/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  static Future<void> saveBookToSharedPreferences(Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bookJson = book.toJsonString();
    await prefs.setString(book.directoryName, bookJson);
    print("Saved book to shared preferences");
  }

  // Retrieve book information from shared preferences
  static Future<Book?> getBookFromSharedPreferences(
      String bookFolderName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookJson = prefs.getString(bookFolderName);

    if (bookJson != null) {
      return Book.fromJsonString(bookJson);
    } else {
      return null;
    }
  }

  static Future<bool> checkSharedPreferences(String bookFolderName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookJson = prefs.getString(bookFolderName);
    return bookJson != null;
  }
}
