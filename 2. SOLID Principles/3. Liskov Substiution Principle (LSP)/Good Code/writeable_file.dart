import 'readable_file.dart';
import 'writeable.dart';

class WriteableFile extends ReadableFile implements Writeable {
  @override
  void write() {
    print('Writing to a file....');
  }
}
