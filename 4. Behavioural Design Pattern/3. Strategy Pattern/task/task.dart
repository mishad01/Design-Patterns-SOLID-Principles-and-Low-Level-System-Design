abstract class Texformatter {
  String formatText(String text);
}

class Document {
  late Texformatter texformatter;
  String _content = '';

  void setTexFormatter(Texformatter textformatter) {
    texformatter = textformatter;
  }

  void setContent(String content) {
    _content = content;
  }

  void formattedText() {
    print(texformatter.formatText(_content));
  }
}

class PlainText extends Texformatter {
  @override
  String formatText(String text) {
    return text;
  }
}

class HtmlFormattedText extends Texformatter {
  @override
  String formatText(String text) {
    return '<html><body>$text</body></html>';
  }
}

class MarkDownFormattedText extends Texformatter {
  @override
  String formatText(String text) {
    return '**$text**';
  }
}

void main() {
  final Document document = Document();
  document.setContent("hello world");

  document.setTexFormatter(PlainText());
  document.formattedText();

  document.setTexFormatter(HtmlFormattedText());
  document.formattedText();

  document.setTexFormatter(MarkDownFormattedText());
  document.formattedText();
}
