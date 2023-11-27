import 'package:reading_app1/models/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  Future<void> saveBookToSharedPreferences(
      String bookFolderName, Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bookJson = book.toJsonString();
    await prefs.setString(bookFolderName, bookJson);
  }

  // Retrieve book information from shared preferences
  Future<Book?> getBookFromSharedPreferences(String bookFolderName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookJson = prefs.getString(bookFolderName);

    if (bookJson != null) {
      return Book.fromJsonString(bookJson);
    } else {
      return null;
    }
  }
}
