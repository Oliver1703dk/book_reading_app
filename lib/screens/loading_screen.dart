import 'package:flutter/material.dart';
import 'package:reading_app1/backend/book_generating.dart';
import 'package:reading_app1/models/book.dart';
import 'package:reading_app1/screens/home_screen.dart';

class MyLoadingScreen extends StatefulWidget {
  @override
  _MyLoadingScreenState createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen> {
  late Future<void> _future;
  late List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _future = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Screen Example'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for the future to complete
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if the future encounters an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Use Future.delayed to schedule the navigation after the build is complete
              Future.delayed(Duration.zero, () {
                // Navigate to the home screen once the future is complete
                navigateToHomeScreen(context);
              });

              // Display some content while transitioning to the home screen
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(books: books),
      ),
    );
  }

  Future<void> fetchData() async {
    // Simulating a time-consuming task
    books = await fetchBooksFromGithub();
    await Future.delayed(Duration(seconds: 0));
    print("Data loaded successfully!");
  }
}
