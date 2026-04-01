import 'text_editor.dart';

void main() {
  TextEditor editor = TextEditor();
  editor.write("Hello World");
  editor.write("Hello everyone");
  //Problem I wanna undo the last write;
  print(editor.getContent());
}
