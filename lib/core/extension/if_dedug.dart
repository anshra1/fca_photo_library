import 'package:flutter/foundation.dart';
import 'dart:developer' as devtools;

extension IfDebugging on String {
  String? get ifDebugging => kDebugMode ? this : null;
}

extension Log on Object {
  void log() => devtools.log(toString());
}
