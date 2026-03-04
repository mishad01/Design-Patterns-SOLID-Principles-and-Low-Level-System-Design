import '../Bad Code/read_only_file.dart';
import 'read_only_file.dart';
import 'readable_file.dart';
import 'writeable_file.dart';

void main() {
  ReadableFile readableFile = ReadOnlyFile();
  readableFile.read();

  WriteableFile writeableFile = WriteableFile();
  writeableFile.read();
  writeableFile.write();

  ReadableFile writeableFile2 = WriteableFile();
  writeableFile2.read();
  writeableFile2.write(); //Getting error here
}
