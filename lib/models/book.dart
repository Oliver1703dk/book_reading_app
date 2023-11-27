// models/book.dart

import 'dart:convert';

class Book {
  final String title;
  final String description;
  final String coverImage;
  final List<KeyPoint> keyPoints; // List of KeyPoint objects
  final String directoryName;

  Book({
    required this.title,
    required this.description,
    required this.coverImage,
    required this.keyPoints,
    required this.directoryName,
  });

  // Convert Book object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'coverImage': coverImage,
      'keyPoints': keyPoints.map((keyPoint) => keyPoint.toJson()).toList(),
      'directoryName': directoryName,
    };
  }

  // Create a Book object from JSON Map
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      coverImage: json['coverImage'] ?? '',
      keyPoints: (json['keyPoints'] as List<dynamic>?)
              ?.map((keyPointJson) => KeyPoint.fromJson(keyPointJson))
              .toList() ??
          [],
      directoryName: json['directoryName'] ?? '',
    );
  }

  // Convert Book object to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Create a Book object from JSON string
  factory Book.fromJsonString(String bookJson) {
    return Book.fromJson(jsonDecode(bookJson));
  }
}

// models/key_point.dart
class KeyPoint {
  final String text;
  final String audioFile;
  final Duration duration; // Duration of the key point audio
  // late Duration duration; // Duration of the key point audio

  KeyPoint({
    required this.text,
    required this.audioFile,
    required this.duration,
  });

  // Convert KeyPoint object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'audioFile': audioFile,
      'duration': duration.inSeconds,
    };
  }

  // Create a KeyPoint object from JSON Map
  factory KeyPoint.fromJson(Map<String, dynamic> json) {
    return KeyPoint(
      text: json['text'] ?? '',
      audioFile: json['audioFile'] ?? '',
      duration: Duration(seconds: json['duration'] ?? 0),
    );
  }
}

Book createBook(Map<String, dynamic> bookData) {
  List<KeyPoint> keyPoints = List.generate(
    bookData["keyPoint"].length,
    (index) => KeyPoint(
      text: bookData["keyPoint"][index],
      audioFile: bookData["audio"][index],
      duration: bookData["duration"][index],
    ),
  );

  return Book(
    title: bookData["name"],
    description: bookData["desc"],
    coverImage: bookData["image"],
    keyPoints: keyPoints,
    directoryName: bookData["directoryName"],
  );
}
