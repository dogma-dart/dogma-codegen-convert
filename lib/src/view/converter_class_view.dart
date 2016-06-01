// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';

import '../../libraries.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [ClassMetadata] for model converters.
class ConverterClassView extends MetadataView<ClassMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The model type that is being converted.
  final TypeMetadata modelType;
  /// Whether the converter is a decoder.
  final bool isDecoder;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates an instance of the [ConverterClassView] class using the
  /// [metadata].
  ///
  /// This assumes that [metadata] has been successfully matched using the
  /// associated functions. It does not perform any error checking.
  factory ConverterClassView(ClassMetadata metadata) {
    var modelDecoder = metadata.interfaces.firstWhere(
        (metadata) => metadata == genericModelDecoderType,
        orElse: () => null
    );

    var modelEncoder = metadata.interfaces.firstWhere(
        (metadata) => metadata == genericModelEncoderType,
        orElse: () => null
    );

    var modelType;
    var isDecoder;

    if (modelDecoder != null) {
      modelType = modelDecoder.arguments[0];
      isDecoder = true;
    } else {
      assert(modelEncoder != null);

      modelType = modelEncoder.arguments[0];
      isDecoder = false;
    }

    return new ConverterClassView._(metadata, modelType, isDecoder);
  }

  /// Creates an instance of the [ConverterClassView] class.
  ConverterClassView._(ClassMetadata metadata, this.modelType, this.isDecoder)
      : super(metadata);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the converter is an encoder.
  bool get isEncoder => !isDecoder;
}
