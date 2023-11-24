// screens/book_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:reading_app1/models/book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int currentKeyPointIndex = 0;
  double audioPlayerProgress = 0.0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // Listen for audio completion
    audioPlayer.onPlayerComplete.listen((event) {
      // Move to the next key point when audio is completed
      if (currentKeyPointIndex < widget.book.keyPoints.length - 1) {
        setState(() {
          currentKeyPointIndex++;
        });
        playAudio(widget.book.keyPoints[currentKeyPointIndex].audioFile);
      } else {
        // If it's the last key point, stop playing
        stopAudio();
      }
    });

    // Listen for audio position changes to update the progress indicator
    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        audioPlayerProgress = position.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() async {
    print('Disposing audioPlayer...');
    // await audioPlayer.dispose();
    try {
      if (isPlaying) {
        audioPlayer.dispose();
      }
    } catch (e) {
      print("Catched $e");
    }

    // await audioPlayer.stop();
    print('audioPlayer disposed.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: Column(
        children: [
          // Cover Image
          Image.network(widget.book.coverImage),

          // Key Point Text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.book.keyPoints[currentKeyPointIndex].text,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),

          // Key Points Circles
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.book.keyPoints.length,
                  (index) => _buildKeyPointCircle(index),
                ),
              ),
            ),
          ),

          // Progress Line and Buttons
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                // Play bar
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Align buttons horizontally
                  children: [
                    // Rewind Button
                    IconButton(
                      icon: Icon(Icons.replay_10),
                      onPressed: () {
                        rewind();
                      },
                    ),

                    // Play/Pause Button
                    IconButton(
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        if (isPlaying) {
                          pauseAudio();
                        } else {
                          playAudio(widget
                              .book.keyPoints[currentKeyPointIndex].audioFile);
                        }
                      },
                    ),

                    // Fast Forward Button
                    IconButton(
                      icon: Icon(Icons.forward_10),
                      onPressed: () {
                        fastForward();
                      },
                    ),
                  ],
                ),

                // LinearProgressIndicator
                LinearProgressIndicator(
                  value: audioPlayerProgress /
                      widget.book.keyPoints[currentKeyPointIndex].duration
                          .inSeconds,
                ),
              ],
            ),
          ),

          // Key Point Indicator
          Text(
              'Key Point ${currentKeyPointIndex + 1} of ${widget.book.keyPoints.length}'),
        ],
      ),
    );
  }

  Widget _buildKeyPointCircle(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentKeyPointIndex = index;
        });
        playAudio(widget.book.keyPoints[index].audioFile);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == currentKeyPointIndex ? Colors.blue : Colors.grey,
        ),
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> playAudio(String audioFile) async {
    try {
      // Convert audioFile to Uri
      UrlSource sourceUri = UrlSource(audioFile);

      // Play audio
      await audioPlayer.play(sourceUri,
          position: Duration(seconds: audioPlayerProgress.round()));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void pauseAudio() {
    audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void stopAudio() {
    audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> fastForward() async {
    final Duration? currentPosition = await audioPlayer.getCurrentPosition();
    final Duration fastForwardDuration = Duration(seconds: 10);
    final Duration newPosition = currentPosition! + fastForwardDuration;

    if (newPosition < widget.book.keyPoints[currentKeyPointIndex].duration) {
      audioPlayer.seek(newPosition);
      setState(() {
        audioPlayerProgress = newPosition.inSeconds.toDouble();
      });
    }
  }

  Future<void> rewind() async {
    final Duration? currentPosition = await audioPlayer.getCurrentPosition();
    final Duration rewindDuration = Duration(seconds: 10);
    final Duration newPosition = currentPosition! - rewindDuration;

    if (newPosition > Duration.zero) {
      audioPlayer.seek(newPosition);
      setState(() {
        audioPlayerProgress = newPosition.inSeconds.toDouble();
      });
    }
  }
}
