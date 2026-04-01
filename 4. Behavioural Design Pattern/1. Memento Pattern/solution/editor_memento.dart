class EditorMemento {
  String content;

  EditorMemento(this.content);

  void editorMemento(String content) {
    // This class is a simple container for the state of the TextEditor.
    // It holds the content of the editor at a specific point in time.
    this.content = content;
  }

  String getContent() {
    return content;
  }
}
