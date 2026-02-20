extension BoolParsing on String? {
  bool parseBool() {
    final string = this;

    if (string?.toLowerCase() == 'true') {
      return true;
    } else if (string?.toLowerCase() == 'false') {
      return false;
    }

    return false;
  }
}
