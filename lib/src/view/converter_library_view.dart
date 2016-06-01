// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/query.dart';

import '../../matcher.dart';
import 'converter_class_view.dart';
import 'codec_class_view.dart';
import 'converter_function_view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [LibraryMetadata] for model converters and codecs.
class ConverterLibraryView extends MetadataView<LibraryMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The converters within the libraries.
  final List<ConverterClassView> converters;
  /// The codecs within the libraries.
  final List<CodecClassView> codecs;
  /// The converter functions within the libraries.
  final List<ConverterFunctionView> functions;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ConverterLibraryView] class.
  ///
  /// The [ConverterLibraryView] contains accessors for functions and classes
  /// that are used for conversions.
  factory ConverterLibraryView(LibraryMetadata metadata) {
    // Get the converters
    var converters = libraryMetadataQueryAll/*<ClassMetadata>*/(
        metadata,
        or(decoderViewMatch, encoderViewMatch),
        includeClasses: true
    ).map/*<ConverterClassView>*/((clazz) => new ConverterClassView(clazz)).toList();

    // Get the codecs
    var codecs = libraryMetadataQueryAll/*<ClassMetadata>*/(
        metadata,
        codecViewMatch,
        includeClasses: true
    ).map/*<CodecClassView>*/((clazz) => new CodecClassView(clazz)).toList();

    // Get the functions
    var functions = <ConverterFunctionView>[];

    return new ConverterLibraryView._(metadata, converters, codecs, functions);
  }

  ConverterLibraryView._(LibraryMetadata metadata,
                         this.converters,
                         this.codecs,
                         this.functions)
      : super(metadata);
}
