// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen_model/build.dart';
import 'package:dogma_codegen_test/build.dart';
import 'package:dogma_codegen_test/convert.dart' as convert;
import 'package:dogma_codegen_test/model.dart' as model;
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'package:dogma_codegen_convert/build.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class _ConverterBuilder extends SourceBuilder
                           with PredefinedMetadataStep,
                                ModelViewStep,
                                ConverterViewGenerationStep,
                                ConverterCodegenStep {
  @override
  final LibraryMetadata library;

  _ConverterBuilder(String package, String libraryOutput, this.library)
      : super(package, libraryOutput, null);
}

void main() {
  test('ModelImplicit libraries', () async {
    var builder = new _ConverterBuilder(
        'dogma_codegen_convert',
        'test/lib/src/convert',
        model.modelImplicitLibrary()
    );

    await testBuilder(
        builder,
        model.modelImplicitLibrary(),
        convert.modelImplicitLibrary()
    );
  });
}
