/*
Code duplication: The openFile() and closeFile() methods are
duplicated in both parsers.
● Any changes to the common logic would require changes in every parser,
violating the DRY (Don’t Repeat Yourself) principle.
 */
class CSVParser {
  void parse() {
    openFile();
    // CSV Specific Parsing Logic
    print("Parsing a CSV File");
    closeFile();
  }

  void openFile() {
    print("Opening File");
  }

  void closeFile() {
    print("Closing File");
  }
}

class JSONParser {
  void parse() {
    openFile();
    // JSON Specific Parsing Logic
    print("Parsing a JSON File");
    closeFile();
  }

  void openFile() {
    print("Opening File");
  }

  void closeFile() {
    print("Closing File");
  }
}

void main() {
  CSVParser csvParser = CSVParser();
  csvParser.parse();
  JSONParser jsonParser = JSONParser();
  jsonParser.parse();
}
