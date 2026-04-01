import 'text_editor_p.dart';

void main() {
  TextEditorP editor = TextEditorP();
  editor.write("Hello World");
  editor.write("Hello everyone");
  //Problem I wanna undo the last write;
  print(editor.getContent());
}
