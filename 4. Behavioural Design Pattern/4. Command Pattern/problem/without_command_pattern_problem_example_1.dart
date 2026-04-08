class TextEditor {
  void boldText() {
    print("Text has been bolded.");
  }

  void italicizeText() {
    print("Text has been italicized.");
  }

  void underlineText() {
    print("Text has been underlined.");
  }
}

//Ui code

class BoldButton {
  late TextEditor textEditor;
  void boldButton(TextEditor textEditor) {
    this.textEditor = textEditor;
  }

  void click() {
    textEditor.boldText();
  }
}

class ItalicizeButton {
  late TextEditor textEditor;
  void italicizeButton(TextEditor textEditor) {
    this.textEditor = textEditor;
  }

  void click() {
    textEditor.italicizeText();
  }
}

class UnderlineButton {
  late TextEditor textEditor;
  void underlineButton(TextEditor textEditor) {
    this.textEditor = textEditor;
  }

  void click() {
    textEditor.underlineText();
  }
}

void main() {
  TextEditor textEditor = TextEditor();
  BoldButton boldButton = BoldButton();
  boldButton.boldButton(textEditor);
  boldButton.click();
  ItalicizeButton italicizeButton = ItalicizeButton();
  italicizeButton.italicizeButton(textEditor);
  italicizeButton.click();
  UnderlineButton underlineButton = UnderlineButton();
  underlineButton.underlineButton(textEditor);
  underlineButton.click();
}
