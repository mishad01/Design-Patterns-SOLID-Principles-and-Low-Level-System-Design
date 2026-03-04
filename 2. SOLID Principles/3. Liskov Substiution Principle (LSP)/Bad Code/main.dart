import 'file.dart';
import 'read_only_file.dart';

void main() {
  FileT file = ReadOnlyFile();
  file.read(); // works fine
  file.write(); //thrwoing exception
  // No we are getting run time error which is vailoation of LSP

  // So parent have read+write but child have only access for read, which is
  // vailoation of LSp

  //so We have to write a good code where we can do this file.write()
}
