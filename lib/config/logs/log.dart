import 'package:logger/logger.dart';
import 'dart:io' as io;

Logger get logger => Log.instance;

class Log extends Logger {
  Log._()
      : super(
          output: ConsoleOutput(),
          printer: PrettyPrinter(
            printTime: true,
            colors: io.stdout.supportsAnsiEscapes,
          ),
        );
  static final instance = Log._();
}

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level.index >= Level.debug.index;
  }
}
