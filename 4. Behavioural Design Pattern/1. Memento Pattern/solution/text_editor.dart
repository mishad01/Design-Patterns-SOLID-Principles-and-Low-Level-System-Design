//A text editor where the user can undo changes, such as text addition, deletion
// or formatting. The editor stores snapshots of its state (text content)
//after each change, enabling the user to revert to any previous state.

class TextEditor {
  String? content;

  void write(String text) {
    this.content = text;
  }

  String getContent() {
    return content!;
  }
}
