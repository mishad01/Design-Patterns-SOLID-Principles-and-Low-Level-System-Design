class AppSettings {
  final String _databaseUrl;
  final String _apiKey;

  AppSettings() : _databaseUrl = 'my_database', _apiKey = 'my_api_key';

  String get getDatabaseUrl => _databaseUrl;
  String get getApiKey => _apiKey;
}
