//Caretaker class : Manage mementos (Snapshots of the Texteditors state)

import 'editor_memento.dart';
import 'text_editor.dart';

class Stack<T> {
  final _list = <T>[];

  void push(T value) => _list.add(value);

  T pop() => _list.removeLast();

  T get top => _list.last;

  bool get isEmpty => _list.isEmpty;

  int get length => _list.length;
}

class CateTaker {
  final Stack<EditorMemento> history = Stack();

  void saveState(TextEditor editor) {
    history.push(editor.save());
  }

  void undo(TextEditor editor) {
    if (!history.isEmpty) {
      history.pop(); // Remove the current state
      editor.restore(history.top);
    }
  }
}
