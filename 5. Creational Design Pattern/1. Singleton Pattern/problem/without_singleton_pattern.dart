import 'app_settings.dart';

void main() {
  AppSettings appSettings = AppSettings();
  AppSettings appSettingsCopy = AppSettings();

  print(appSettings.getApiKey);
  print(appSettingsCopy.getApiKey);

  //More memory is used as two different objects are created
  //print(identical(appSettings, appSettingsCopy)); // false
  print(appSettings == appSettingsCopy);
}
