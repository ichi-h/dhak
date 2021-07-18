import 'package:console/console.dart';

void colorPrint(String text, Color color) {
  var pen = TextPen();
  pen.setColor(color);
  pen.text(text);
  pen.print();
}
