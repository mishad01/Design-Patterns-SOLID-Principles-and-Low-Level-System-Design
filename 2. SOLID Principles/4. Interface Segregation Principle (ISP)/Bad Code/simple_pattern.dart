import 'document.dart';
import 'machine.dart';

class SimplePattern extends Machine {
  @override
  void copy(Document document) {
    // TODO: implement copy
  }

  @override
  void print(Document document) {
    throw UnimplementedError();
  }

  @override
  void scan(Document document) {
    throw UnimplementedError();
  }
}
