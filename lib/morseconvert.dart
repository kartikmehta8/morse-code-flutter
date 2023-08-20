///Using morse: ^0.1.4+1 from pub.dev which could not be used as a package because it's not null safe!
/// The [Morse] class can be used to decode morse code to readable text and back.
///
class Morse {
  /// The string of text that will be used to cipher morse code
  final String? _message;

  /// The [Morse] constructor can be used to initialize [Morse] with a string of text to later decode or encode.
  Morse([this._message]);

  /// Decodes the given morse code to human-readable text.
  String decode([String? encodedMessage]) {
    return _cipher(encodedMessage == null, true, encodedMessage as String);
  }

  /// Encodes the given string to morse code.
  String encode([String? message]) {
    return _cipher(message == null, false, message as String);
  }

  /// Sets a separate string and decides whether to use the message initialized by constructor or method.
  /// Fires up another function in order to split the given string for querying.
  String _cipher(bool isNull, bool isMorse, String message) {
    String string = (isNull) ? _message as String : message;
    return _cipherMessage(string.toLowerCase(), isMorse);
  }

  /// Splits the given string accordingly.
  /// Initiates another function to query each word (morse) / letter (readable) in the array.
  /// Returns a full message either in morse or readable text.
  String _cipherMessage(String message, bool isMorse) {
    return message
        .split((isMorse) ? ' ' : '')
        .map((letter) => _cipherLetter(letter, isMorse))
        .join((isMorse) ? '' : ' ');
  }

  /// Queries a list of morse codes and returns the matching letter's morse code or the other way around.
  String _cipherLetter(String letter, bool isMorse) {
    String l = (isMorse) ? '⍰' : '';
    _morse.forEach((mapLetter, code) {
      String check = (isMorse) ? code : mapLetter;
      String retrieve = (isMorse) ? mapLetter : code;
      if (letter.toLowerCase() == check.toLowerCase()) {
        l = retrieve;
      }
    });
    String _return = (isMorse) ? l.toLowerCase() : l;
    return _return;
  }

  /// Dictionary of each character's morse code
  final Map<String, String> _morse = {
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
  };
}
