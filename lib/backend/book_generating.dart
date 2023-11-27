import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:reading_app1/models/book.dart';

Future<List<Book>> fetchBooksFromGithub() async {
  final String githubRepoUrl =
      'https://api.github.com/repos/Oliver1703dk/books/contents/books/';

  try {
    final http.Response response = await http.get(
      Uri.parse(githubRepoUrl),
      //     headers: {
      //   'Authorization':
      //       'Bearer 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',
      // }
    );

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
  final String keyPointsTimeUrl = '$bookUrl/key_points_time.txt';
  // final String audioFolderUrl = '$bookUrl/audio/';
  final String audioFolderUrl = '$bookUrl/audio/';
  // print(keyPointsUrl);
  // print(descUrl);
  // print(audioFolderUrl);
  // print(imageUrl);
  final String bookFolderName = bookFolder;

  final http.Response descResponse = await http.get(Uri.parse(descUrl));
  final http.Response keyPointsResponse =
      await http.get(Uri.parse(keyPointsUrl));
  final http.Response keyPointsTimeResponse =
      await http.get(Uri.parse(keyPointsTimeUrl));

  if (descResponse.statusCode == 200 &&
      keyPointsResponse.statusCode == 200 &&
      keyPointsTimeResponse.statusCode == 200) {
    final String title = descResponse.body.split('\n')[0];
    final String description = descResponse.body.split('\n')[1];

    final List<String> keyPoints = keyPointsResponse.body.split('\n');
    final List<String> keyPointsTime = keyPointsTimeResponse.body.split('\n');
    print(keyPoints.length);
    print(keyPointsTime.length);

    final List<KeyPoint> keyPointList = [];
    for (int i = 0; i < keyPoints.length; i++) {
      final String keyPointText = keyPoints[i];
      final String audioFileUrl = '$audioFolderUrl${i + 1}.wav';
      final int keyPointsTimeText = int.parse(keyPointsTime[i]);

      keyPointList.add(KeyPoint(
        text: keyPointText,
        audioFile: audioFileUrl,
        // Assuming the duration is constant for each key point, adjust as needed
        // duration: Duration(seconds: 10),
        duration: Duration(seconds: keyPointsTimeText),
        // duration: Duration(seconds: await getWavFileLength(audioFileUrl)),
      ));
    }

    return Book(
        title: title,
        description: description,
        coverImage: imageUrl,
        keyPoints: keyPointList,
        directoryName: bookFolderName);
  } else {
    throw Exception('Failed to load book details');
  }
}

// Future<int> getWavFileLength(String fileUrl) async {
//   try {
//     // Download the first 44 bytes of the file (WAV header size)
//     http.Response response = await http.get(Uri.parse(fileUrl));
//     Uint8List headerBytes =
//         Uint8List.fromList(response.bodyBytes.sublist(0, 44));

//     // Extract information from the header
//     ByteData headerData = ByteData.sublistView(headerBytes, 0, 44);
//     int dataSize = headerData.getInt32(40, Endian.little);

//     // Calculate the length based on the data size and sample rate
//     int sampleRate = headerData.getInt32(24, Endian.little);
//     int numberOfChannels = headerData.getUint16(22, Endian.little);
//     int bitsPerSample = headerData.getUint16(34, Endian.little);

//     double lengthInSeconds =
//         dataSize / (sampleRate * numberOfChannels * (bitsPerSample / 8));

//     // Return the length in seconds
//     return lengthInSeconds.toInt();
//   } catch (e) {
//     print("Error: $e");
//     return -1; // Return -1 to indicate an error
//   }
// }

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
