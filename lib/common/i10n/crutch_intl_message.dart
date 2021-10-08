import 'package:intl/intl.dart';

class CrutchIntlMessage {
  static String getMessage(String name) {
    return Intl.message(
      '',
      name: name,
      desc: '',
      args: [],
    );
  }
}
