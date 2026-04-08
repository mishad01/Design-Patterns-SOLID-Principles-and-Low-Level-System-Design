//Command Interface
abstract class Command {
  void execute();
}

//Concrete classes for commands
class BoldCommand implements Command {
  final TextEditor textEditor;

  BoldCommand(this.textEditor);

  @override
  void execute() {
    textEditor.boldText();
  }
}

class ItalicizeCommand implements Command {
  final TextEditor textEditor;

  ItalicizeCommand(this.textEditor);

  @override
  void execute() {
    textEditor.italicizeText();
  }
}

class UnderlineCommand implements Command {
  final TextEditor textEditor;

  UnderlineCommand(this.textEditor);

  @override
  void execute() {
    textEditor.underlineText();
  }
}

class Button {
  Command? command;

  void setCommand(Command command) {
    this.command = command;
  }

  void click() {
    command?.execute();
  }
}

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

void main() {
  TextEditor textEditor = TextEditor();

  // Create command objects
  final boldCommand = BoldCommand(textEditor);
  final italicizeCommand = ItalicizeCommand(textEditor);
  final underlineCommand = UnderlineCommand(textEditor);

  // Create buttons and set commands
  final boldButton = Button();
  boldButton.setCommand(boldCommand);

  final italicizeButton = Button();
  italicizeButton.setCommand(italicizeCommand);

  final underlineButton = Button();
  underlineButton.setCommand(underlineCommand);

  // Simulate button clicks
  boldButton.click(); // Text has been bolded.
  italicizeButton.click(); // Text has been italicized.
  underlineButton.click(); // Text has been underlined.
}
