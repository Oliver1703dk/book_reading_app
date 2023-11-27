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
    Map<String, dynamic> rdpd = {
      "name": "Rich Dad Poor Dad",
      "desc": "This is the description of Rich Dad Poor Dad",
      "audio": [
        'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/1.mp3',
        'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/2.mp3',
        // Add more audio URLs as needed
      ],
      "duration": [
        Duration(seconds: 176),
        Duration(seconds: 141),
        // Add more durations as needed
      ],
      "keyPoint": [
        "The Rich Don't Work for Money",
        "Assets vs. Liabilities",
        // Add more key points as needed
      ],
      "image":
          "https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/rdpd_image.png",
    };

    Map<String, dynamic> taonr = {
      "name": "The Almanack Of Naval Ravikant",
      "desc": "This is the description of The Almanack Of Naval Ravikant",
      "audio": [
        'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/1.wav',
        'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/2.wav',
        // Add more audio URLs as needed
      ],
      "duration": [
        Duration(seconds: 120),
        Duration(seconds: 123),
        // Add more durations as needed
      ],
      "keyPoint": [
        "Happiness and Wealth",
        "Personal Development",
        // Add more key points as needed
      ],
      "image":
          "https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/taonr_image.png",
    };

    Map<String, dynamic> dw = {
      "name": "Deep Work: Rules for Focused Success in a Distracted World",
      "desc":
          "This is the description of Deep Work: Rules for Focused Success in a Distracted World",
      "audio": [
        'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/1.wav',
        'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/2.wav',
        // Add more audio URLs as needed
      ],
      "duration": [
        Duration(seconds: 227),
        Duration(seconds: 224),
        // Add more durations as needed
      ],
      "keyPoint": [
        "Definition of Deep Work",
        "Shallow Work vs. Deep Work",
        // Add more key points as needed
      ],
      "image":
          "https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/dw_image.png",
    };

    // List<Book> books = [
    //   // createBook(rdpd),
    //   // createBook(taonr),
    //   // createBook(dw),
    //   // Add more books as needed
    // ];

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
    await Future.delayed(Duration(seconds: 1));
    print("Data loaded successfully!");
  }
}
