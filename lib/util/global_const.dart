class GlobalConst {
  static const VERSION = '0.2.1';

  static final letters = [
    GlobalConst.LOWER_CASE,
    GlobalConst.UPPER_CASE,
    GlobalConst.NUMBERS
  ].expand((element) => element).toList();

  static const LOWER_CASE = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];

  static const UPPER_CASE = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  static const NUMBERS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
}
