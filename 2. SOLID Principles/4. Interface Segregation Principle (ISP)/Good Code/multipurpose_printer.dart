import '../Bad Code/document.dart';
import 'copier.dart';
import 'printer.dart';
import 'scanner.dart';

class MultipurposePrinter implements Printer, Scanner, Copier {
  @override
  void copy(Document document) {
    // TODO: implement copy
  }

  @override
  void printer(Document document) {
    // TODO: implement printer
  }

  @override
  void scan(Document document) {
    // TODO: implement scan
  }
}
