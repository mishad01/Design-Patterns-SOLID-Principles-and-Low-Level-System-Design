class AppSettings {
  AppSettings._() : _databaseUrl = 'my_database', _apiKey = 'my_api_key';

  static final AppSettings _instance = AppSettings._();

  factory AppSettings() {
    return _instance;
  }

  final String _databaseUrl;
  final String _apiKey;

  String get databaseUrl => _databaseUrl;
  String get apiKey => _apiKey;
}
