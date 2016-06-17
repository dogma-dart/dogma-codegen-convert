// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';
import 'package:logging/logging.dart';

import 'build.dart' as build;
import 'matcher.dart' as matcher;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  // Start logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  // Run tests
  group('Build tests', build.main);
  group('Matcher tests', matcher.main);
}
