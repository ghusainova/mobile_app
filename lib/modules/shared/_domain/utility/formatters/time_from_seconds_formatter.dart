String formatTimeFromSeconds(int seconds) {
  return Duration(seconds: seconds).toString().split('.').first.padLeft(8, '0');
}
