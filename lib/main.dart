// main.dart
import 'package:flutter/material.dart';
import 'package:reading_app1/models/book.dart';
import 'package:reading_app1/screens/home_screen.dart';
import 'package:reading_app1/screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // // Rich Dad Poor Dad
  // final String namerdpd = "Rich Dad Poor Dad";
  // final String descrdpd = "This is the description of Rich Dad Poor Dad";
  // final List audioFilesrdpd = [
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/1.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/2.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/3.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/4.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/5.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/6.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/7.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/8.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/9.mp3',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/audio/10.mp3'
  // ];
  // final List durationsrdpd = [
  //   Duration(seconds: 176),
  //   Duration(seconds: 141),
  //   Duration(seconds: 169),
  //   Duration(seconds: 160),
  //   Duration(seconds: 166),
  //   Duration(seconds: 167),
  //   Duration(seconds: 162),
  //   Duration(seconds: 149),
  //   Duration(seconds: 159),
  //   Duration(seconds: 143)
  // ];
  // final List keyPointsrdpd = [
  //   "The Rich Don't Work for Money",
  //   "Assets vs. Liabilities",
  //   "Mindset Matters",
  //   "Education Goes Beyond School",
  //   "Understanding Taxes",
  //   "Entrepreneurship and Investing",
  //   "The Importance of Taking Action",
  //   "Work to Learn, Not for Pay",
  //   "Wealthy People Make Money Work for Them",
  //   "Financial Independence is a Mindset"
  // ];
  // final String imagerdpd =
  //     "https://github.com/Oliver1703dk/AudioFiles/raw/main/books/rdpd/image.png";

  // // The Almanack Of Naval Ravikant
  // final String nametaonr = "The Almanack Of Naval Ravikant";
  // final String desctaonr =
  //     "This is the description of The Almanack Of Naval Ravikant";
  // final List audioFilestaonr = [
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/1.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/2.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/3.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/4.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/5.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/6.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/7.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/8.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/9.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/10.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/11.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/audio/12.wav'
  // ];
  // final List durationstaonr = [
  //   Duration(seconds: 120),
  //   Duration(seconds: 123),
  //   Duration(seconds: 135),
  //   Duration(seconds: 120),
  //   Duration(seconds: 116),
  //   Duration(seconds: 126),
  //   Duration(seconds: 133),
  //   Duration(seconds: 126),
  //   Duration(seconds: 135),
  //   Duration(seconds: 124),
  //   Duration(seconds: 113),
  //   Duration(seconds: 127)
  // ];
  // final List keyPointstaonr = [
  //   "Happiness and Wealth",
  //   "Personal Development",
  //   "Time and Attention",
  //   "Decision-Making",
  //   "Success and Happiness",
  //   "Mindfulness and Meditation",
  //   "Entrepreneurship",
  //   "Learning and Reading",
  //   "Wealth Creation",
  //   "Relationships",
  //   "Gratitude",
  //   "Freedom"
  // ];
  // final String imagetaonr =
  //     "https://github.com/Oliver1703dk/AudioFiles/raw/main/books/taonr/image.png";

  // // Deep Work: Rules for Focused Success in a Distracted World
  // final String namedw =
  //     "Deep Work: Rules for Focused Success in a Distracted World";
  // final String descdw =
  //     "This is the description of Deep Work: Rules for Focused Success in a Distracted World";
  // final List audioFilesdw = [
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/1.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/2.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/3.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/4.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/5.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/6.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/7.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/8.wav',
  //   'https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/audio/9.wav'
  // ];
  // final List durationsdw = [
  //   Duration(seconds: 227),
  //   Duration(seconds: 224),
  //   Duration(seconds: 156),
  //   Duration(seconds: 184),
  //   Duration(seconds: 180),
  //   Duration(seconds: 195),
  //   Duration(seconds: 190),
  //   Duration(seconds: 153),
  //   Duration(seconds: 166)
  // ];
  // final List keyPointsdw = [
  //   "Definition of Deep Work",
  //   "Shallow Work vs. Deep Work",
  //   "Productivity and Depth",
  //   "The Four Disciplines of Deep Work",
  //   "Deep Work and Skill Development",
  //   "The 4DX Formula",
  //   "Rituals and Routines",
  //   "The Idea of Attention Residue",
  //   "The Deep Work Hypothesis"
  // ];
  // final String imagedw =
  //     "https://github.com/Oliver1703dk/AudioFiles/raw/main/books/dw/image.png";

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> rdpd = {
    //   "name": namerdpd,
    //   "desc": descrdpd,
    //   "audio": audioFilesrdpd,
    //   "duration": durationsrdpd,
    //   "keyPoint": keyPointsrdpd,
    //   "image": imagerdpd
    // };
    // Map<String, dynamic> taonr = {
    //   "name": nametaonr,
    //   "desc": desctaonr,
    //   "audio": audioFilestaonr,
    //   "duration": durationstaonr,
    //   "keyPoint": keyPointstaonr,
    //   "image": imagetaonr
    // };
    // Map<String, dynamic> dw = {
    //   "name": namedw,
    //   "desc": descdw,
    //   "audio": audioFilesdw,
    //   "duration": durationsdw,
    //   "keyPoint": keyPointsdw,
    //   "image": imagedw
    // };
    return MaterialApp(home: MyLoadingScreen()
        //     HomeScreen(
        //   // Pass your list of books here
        //   books: [
        //     createBook(rdpd),
        //     createBook(taonr),
        //     createBook(dw)

        //     // Add more books as needed
        //   ],
        // ),
        );
  }
}
