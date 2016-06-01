// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';

import '../../codegen.dart';
import '../../view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates source code for model proxies.
class ConverterCodegenStep implements SourceGenerationStep {
  @override
  String sourceCode(MetadataView<LibraryMetadata> view) {
    var converterLibraryView = view as ConverterLibraryView;
    var buffer = new StringBuffer();

    for (var converter in converterLibraryView.converters) {
      generateConverter(converter, buffer);
    }

    for (var codec in converterLibraryView.codecs) {
      generateCodec(codec, buffer);
    }

    for (var function in converterLibraryView.functions) {
      generateFunction(function, buffer);
    }

    return buffer.toString();
  }
}
