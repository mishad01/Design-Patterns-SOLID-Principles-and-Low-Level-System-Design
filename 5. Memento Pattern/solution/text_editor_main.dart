import 'cate_taker.dart';
import 'text_editor.dart';

void main() {
  TextEditor editor = TextEditor();
  CateTaker cateTaker = CateTaker(); //History // State Management

  editor.write("Hello World");
  cateTaker.saveState(editor); // Save "Hello World" state

  editor.write("Hello everyone");
  cateTaker.saveState(editor);

  // Don't save here — we want undo to revert this change

  cateTaker.undo(editor); // Restore "Hello World"
  print(editor.getContent()); // prints: Hello World
}
