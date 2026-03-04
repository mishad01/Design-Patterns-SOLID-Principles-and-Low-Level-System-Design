import 'file.dart';

class ReadOnlyFile extends FileT {
  @override
  void write() {
    throw Exception('Cannot write to a read-only file');
  }
}

class File {}
