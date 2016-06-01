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

import 'converter_codegen_step.dart';
import 'converter_view_generation_step.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@RegisterBuilder('convert')
class ConverterBuilder extends SourceBuilder
                          with AnalyzerMetadataStep,
                               ModelViewStep,
                               ConverterViewGenerationStep,
                               ConverterCodegenStep {
  ConverterBuilder(String package, String libraryOutput)
      : super(package, libraryOutput, null);

  @override
  final List<AnalyzeAnnotation> annotationCreators = <AnalyzeAnnotation>[];
}
