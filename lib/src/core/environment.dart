class Environment {
  static const String apiBaseUrl = String.fromEnvironment('apiBaseUrl', defaultValue: '');

  static const String auddApiToken = String.fromEnvironment('AUDD_API_TOKEN');
}
