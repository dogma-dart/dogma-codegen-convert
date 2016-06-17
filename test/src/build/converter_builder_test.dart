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
import 'package:test/test.dart';

import 'package:dogma_codegen_convert/build.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  test('Convert libraries', () async {
    var modelConfig = new BuilderConfig<TargetConfig>()
        ..libraryOutput = 'test/lib/src/model';
    var modelRootConfig = new RootLibraryBuilderConfig()
        ..libraryPath = 'test/lib/model.dart'
        ..sourceDirectory = 'test/lib/src/model';
    var converterConfig = new BuilderConfig<ConverterTargetConfig>()
        ..libraryOutput = 'test/lib/src/convert';

    var predefined = [
      new PredefinedModelBuilder(modelConfig, model.modelImplicitLibrary()),
      new PredefinedModelBuilder(modelConfig, model.modelExplicitLibrary()),
      new PredefinedModelBuilder(modelConfig, model.modelOptionalLibrary()),
      new PredefinedModelBuilder(modelConfig, model.modelRecursiveLibrary())
    ];

    var pipeline = [
      new RootLibraryBuilder(modelRootConfig),
      new ConverterBuilder(converterConfig)
    ];

    var outputs = [
      convert.modelImplicitLibrary(),
      convert.modelExplicitLibrary()
    ];

    await testWithPredefinedMetadata(predefined, pipeline, outputs);
  });
}
