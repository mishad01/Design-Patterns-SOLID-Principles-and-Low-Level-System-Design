/*
Singleton Design Pattern
The Singleton pattern is used when exactly one instance of a class is required to
coordinate actions across the system.
When to Use
● Global resource management (e.g., managing database connections,
logging).
● Configuration settings in applications that need to be shared
 */
import 'app_settings.dart';

void main() {
  AppSettings appSettings = AppSettings();
  AppSettings appSettingsCopy = AppSettings();

  print(appSettings.apiKey);
  print(appSettingsCopy.apiKey);

  print(appSettings == appSettingsCopy);
}
