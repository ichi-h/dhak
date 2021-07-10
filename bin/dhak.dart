import 'dart:io';
import 'package:dbcrypt/dbcrypt.dart';

void main(List<String> arguments) {
  stdin.echoMode = false;

  print('Type some words: ');

  var words = stdin.readLineSync().toString();

  DBCrypt dbCrypt = DBCrypt();
  String hashedPwd = dbCrypt.hashpw(words, dbCrypt.gensalt());

  print('\nInput words: ');
  print(words);

  print('\nHashed words: ');
  print(hashedPwd);
}
