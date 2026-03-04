import 'document.dart';

abstract class Machine {
  void print(Document document);
  void scan(Document document);
  void copy(Document document);
}
