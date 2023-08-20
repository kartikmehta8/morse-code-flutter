import 'package:flutter/material.dart';

class MorseCodePage extends StatelessWidget {
  final Map<String, String> morseCodeMap = {
    '': '⍰',
    ' ': '/',
    'a': '.-',
    'b': '-...',
    'c': '-.-.',
    'd': '-..',
    'e': '.',
    'f': '..-.',
    'g': '--.',
    'h': '....',
    'i': '..',
    'j': '.---',
    'k': '-.-',
    'l': '.-..',
    'm': '--',
    'n': '-.',
    'o': '---',
    'p': '.--.',
    'q': '--.-',
    'r': '.-.',
    's': '...',
    't': '-',
    'u': '..-',
    'v': '...-',
    'w': '.--',
    'x': '-..-',
    'y': '-.--',
    'z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    '!': '-.-.--',
    '?': '..--..',
    '@': '.--.-.',
    '=': '-...-',
    '&': '.-...',
    '(': '-.--.',
    ')': '-.--.-',
    '-': '-....-',
    '_': '..--.-',
    '+': '.-.-.',
    ';': '-.-.-.',
    ':': '---...',
    '\$': '...-..-',
    '\'': '.----.',
    '\"': '.-..-.',
    ',': '--..--',
    '.': '.-.-.-',
    '/': '-..-.',
    // ... Add all the Morse codes here
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morse Code'),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView.builder(
        itemCount: morseCodeMap.length,
        itemBuilder: (context, index) {
          final word = morseCodeMap.keys.elementAt(index);
          final morseCode = morseCodeMap[word];
          return ListTile(
            title: Text(
              word,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              morseCode.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.code),
            onTap: () {
              // You can add any action here when a list item is tapped
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MorseCodePage()));
}
