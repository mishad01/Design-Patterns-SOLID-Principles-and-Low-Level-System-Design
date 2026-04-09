abstract class DataParser {
  void readData() {
    print("Reading Data");
  }

  void processData();
  void writeData() {
    print("Writing Data");
  }

  void parse() {
    readData();
    processData();
    writeData();
  }
}

class CSVParser extends DataParser {
  @override
  void processData() {
    print('Parsing CSV Data');
  }
}

class JSONParser extends DataParser {
  @override
  void processData() {
    print('Parsing JSON Data');
  }
}

void main() {
  CSVParser csvParser = CSVParser();
  JSONParser jsonParser = JSONParser();
  csvParser.parse();
  jsonParser.parse();
}
