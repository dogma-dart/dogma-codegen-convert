// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen/runner.dart';
import 'package:dogma_codegen_model/build.dart';
import 'package:dogma_source_analyzer/analyzer.dart';

import 'converter_target_config.dart';
import 'converter_codegen_step.dart';
import 'converter_view_generation_step.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [SourceBuilder] that generates code to convert from Map data to Plain
/// Old Dart Objects (PODOs).
@RegisterBuilder('convert')
class ConverterBuilder extends SourceBuilder<ConverterTargetConfig>
                          with AnalyzerMetadataStep,
                               ModelViewStep,
                               ConverterViewGenerationStep,
                               ConverterCodegenStep {
  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [ConverterBuilder] with the given [config].
  ConverterBuilder(BuilderConfig<ConverterTargetConfig> config)
      : super(config);

  //---------------------------------------------------------------------
  // AnalyzerMetadataStep
  //---------------------------------------------------------------------

  @override
  final List<AnalyzeAnnotation> annotationCreators = <AnalyzeAnnotation>[];

  @override
  String filename(String value) {
    var split = value.split('.');
    split[0] = '${split[0]}_convert';

    return split.join('.');
  }
}
