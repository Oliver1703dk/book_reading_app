import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:reading_app1/models/book.dart';

Future<List<Book>> fetchBooksFromGithub() async {
  final String githubRepoUrl =
      'https://api.github.com/repos/Oliver1703dk/books/contents/books/';

  try {
    final http.Response response =
        await http.get(Uri.parse(githubRepoUrl), headers: {
      'Authorization':
          'Bearer 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',
    });

    if (response.statusCode == 200) {
      // final List<String> bookFolders =
      //     json.decode(response.body).cast<String>();

      final List<String> bookFolders =
          (json.decode(response.body) as List<dynamic>)
              .where((item) => item['type'] == 'dir') // Filter only directories
              .map((item) => item['name'].toString())
              .toList();
      print(bookFolders);

      final List<Book> books = [];
      for (final String bookFolder in bookFolders) {
        final Book book = await createBookFromFolder(githubRepoUrl, bookFolder);
        books.add(book);
      }

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<Book> createBookFromFolder(String baseUrl, String bookFolder) async {
  final String githubRepoUrl =
      "https://raw.githubusercontent.com/Oliver1703dk/books/main/books/";

  // final String bookUrl = '$baseUrl$bookFolder/';
  final String bookUrl = '$githubRepoUrl$bookFolder/';

  final String imageUrl = '$bookUrl/image.png';
  final String descUrl = '$bookUrl/desc.txt';
  final String keyPointsUrl = '$bookUrl/key_points.txt';
  // final String audioFolderUrl = '$bookUrl/audio/';
  final String audioFolderUrl = '$bookUrl/audio/';
  // print(keyPointsUrl);
  // print(descUrl);
  // print(audioFolderUrl);
  // print(imageUrl);

  final http.Response descResponse = await http.get(Uri.parse(descUrl));
  final http.Response keyPointsResponse =
      await http.get(Uri.parse(keyPointsUrl));

  if (descResponse.statusCode == 200 && keyPointsResponse.statusCode == 200) {
    final String title = descResponse.body.split('\n')[0];
    final String description = descResponse.body.split('\n')[1];

    final List<String> keyPoints = keyPointsResponse.body.split('\n');

    final List<KeyPoint> keyPointList = [];
    for (int i = 0; i < keyPoints.length; i++) {
      final String keyPointText = keyPoints[i];
      final String audioFileUrl = '$audioFolderUrl${i + 1}.wav';

      keyPointList.add(KeyPoint(
        text: keyPointText,
        audioFile: audioFileUrl,
        // Assuming the duration is constant for each key point, adjust as needed
        duration: const Duration(seconds: 10),
      ));
    }

    return Book(
      title: title,
      description: description,
      coverImage: imageUrl,
      keyPoints: keyPointList,
    );
  } else {
    throw Exception('Failed to load book details');
  }
}

void main() async {
  try {
    final List<Book> books = await fetchBooksFromGithub();
    for (final Book book in books) {
      print('Title: ${book.title}');
      print('Description: ${book.description}');
      print('Cover Image: ${book.coverImage}');
      print('Key Points:');
      for (final KeyPoint keyPoint in book.keyPoints) {
        print('  - ${keyPoint.text}');
        print('    Audio File: ${keyPoint.audioFile}');
        print('    Duration: ${keyPoint.duration}');
      }
      print('\n');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class Book_generating {}
