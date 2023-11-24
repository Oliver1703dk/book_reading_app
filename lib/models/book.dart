// models/book.dart
class Book {
  final String title;
  final String description;
  final String coverImage;
  final List<KeyPoint> keyPoints; // List of KeyPoint objects

  Book({
    required this.title,
    required this.description,
    required this.coverImage,
    required this.keyPoints,
  });
}

// models/key_point.dart
class KeyPoint {
  final String text;
  final String audioFile;
  final Duration duration; // Duration of the key point audio

  KeyPoint({
    required this.text,
    required this.audioFile,
    required this.duration,
  });
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
  );
}
