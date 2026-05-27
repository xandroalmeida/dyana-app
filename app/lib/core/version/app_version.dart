class AppVersion {
  static const value = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: 'dev',
  );
}
