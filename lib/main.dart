import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app.dart';

import 'utils.dart';

void main() {
  setupLogger();
  runApp(const ProviderScope(child: MyApp()));
}
