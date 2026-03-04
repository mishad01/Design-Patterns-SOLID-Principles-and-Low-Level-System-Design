import '../Bad Code/document.dart';
import 'printer.dart';

class SimplePrinter implements Printer {
  @override
  void printer(Document document) {
    print('Printing document....');
  }
}
